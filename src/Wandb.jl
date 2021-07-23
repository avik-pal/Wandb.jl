module Wandb

using PyCall, Conda, Requires

const wandb = PyNULL()

function __init__()
    copy!(wandb, pyimport("wandb"))
    @info "Using Wandb version $(wandb.__version__)"

    @require FluxTraining="7bf95e4d-ca32-48da-9824-f0dc5310474f" begin
        include("fluxtraining.jl")
    end
end

using Base.CoreLogging:
    CoreLogging,
    AbstractLogger,
    LogLevel,
    Info,
    handle_message,
    shouldlog,
    min_enabled_level,
    catch_exceptions


login(; kwargs...) = wandb.login(; kwargs...)

mutable struct WandbLogger <: AbstractLogger
    wrun::PyObject
    step_increment::Int
    global_step::Int
    min_level::LogLevel
end

function WandbLogger(;
    project,
    name = nothing,
    min_level = Info,
    step_increment = 1,
    start_step = 0,
    kwargs...,
)
    wrun = wandb.init(; project = project, name = name, kwargs...)
    if wrun.name != name
        @warn "There is an ongoing wandb run. Please `close` the run before initializing a new one."
    end
    return WandbLogger(wrun, step_increment, start_step, min_level)
end

increment_step!(lg::WandbLogger, Δ_Step) = lg.global_step += Δ_Step

# https://docs.wandb.ai/guides/track/log
# Probably shouldn't do this but want to stay consistent with the
# Wandb API
Base.log(lg::WandbLogger, logs::Dict; kwargs...) =
    lg.wrun.log(logs; kwargs...)

# https://docs.wandb.ai/guides/track/config
update_config!(lg::WandbLogger, dict::Dict; kwargs...) =
    lg.wrun.config.update(dict; kwargs...)

# https://docs.wandb.ai/ref/python/finish
Base.close(lg::WandbLogger; kwargs...) = lg.wrun.finish(; kwargs...)

function finish(lg::WandbLogger; kwargs...)
    @warn "The desired way to end the run is `close`. Please update your code to use the same" maxlog =
        1
    close(lg; kwargs...)
end

# https://docs.wandb.ai/ref/python/save
save(lg::WandbLogger, file::String; kwargs...) = lg.wrun.save(file; kwargs...)

get_config(lg::WandbLogger) = lg.wrun.config
get_config(lg::WandbLogger, key::String) = get(lg.wrun.config, key)

# Logging Types: Image, Video, Histogram, 3D Objects, PR Curve
## We assume the images to be ordered as per Flux conventions
Image(img::AbstractArray{T,3}; kwargs...) where {T} =
    wandb.Image(permutedims(img, (3, 1, 2)); kwargs...)
Image(img::AbstractMatrix; kwargs...) =
    wandb.Image(img; kwargs...)
Image(img::String; kwargs...) = wandb.Image(img; kwargs...)

Video(vid::AbstractArray{T,4}; kwargs...) where {T} =
    wandb.Video(permutedims(vid, (4, 3, 2, 1)); kwargs...)
Video(vid::AbstractArray{T,3}; kwargs...) where {T} =
    wandb.Video(permutedims(vid, (3, 2, 1)); kwargs...)
Video(vid::String; kwargs...) = wandb.Video(vid; kwargs...)

Histogram(x::AbstractArray; kwargs...) = wandb.Histogram(x; kwargs...)

Object3D(path::String) = wandb.Object3D(open(path, 'r'))

precision_recall(
    y_test::AbstractVector,
    y_probs::AbstractVector,
    labels::AbstractVector,
) = wandb.plots.precision_recall(y_test, y_probs, labels)


# AbstractLogger interface
# Mostly a blunt copy from CometLogger.jl
# https://github.com/rejuvyesh/CometLogger.jl/blob/master/src/CometLogger.jl
CoreLogging.catch_exceptions(lg::WandbLogger) = false

CoreLogging.min_enabled_level(lg::WandbLogger) = lg.min_level

# For now, log everything that is above the lg.min_level
CoreLogging.shouldlog(lg::WandbLogger, level, _module, group, id) = true


function preprocess(name, val::T, data) where {T}
    if isstructtype(T) && !(val isa PyObject)
        fn = logable_propertynames(val)
        for f in fn
            prop = getfield(val, f)
            preprocess(name * "/$f", prop, data)
        end
    else
        push!(data, name => val)
    end
    data
end

"""
    logable_propertynames(val::Any)
Returns a tuple with the name of the fields of the structure `val` that
should be logged to Wandb. This function should be overridden when
you want Wandb to ignore some fields in a structure when logging
it. The default behaviour is to return the  same result as `propertynames`.
See also: [`Base.propertynames`](@ref)
"""
logable_propertynames(val::Any) = propertynames(val)


## Default unpacking of key-value dictionaries
function preprocess(name, dict::AbstractDict, data)
    for (key, val) in dict
        # convert any key into a string, via interpolating it
        preprocess("$name/$key", val, data)
    end
    return data
end

# Split complex numbers into real/complex pairs
preprocess(name, val::Complex, data) =
    push!(data, name * "/re" => real(val), name * "/im" => imag(val))

process(lg::WandbLogger, name::AbstractString, obj, step::Int) =
    log(lg, Dict(name => obj); step = step)


function CoreLogging.handle_message(
    lg::WandbLogger,
    level,
    message,
    _module,
    group,
    id,
    file,
    line;
    kwargs...,
)
    i_step = lg.step_increment # :log_step_increment default value

    if !isempty(kwargs)
        data = Vector{Pair{String,Any}}()
        # ∀ (k-v) pairs, decompose values into objects that can be serialized
        for (key, val) in pairs(kwargs)
            # special key describing step increment
            if key == :log_step_increment
                i_step = val
                continue
            end
            preprocess(message * "/$key", val, data)
        end
        iter = increment_step!(lg, i_step)
        for (name, val) in data
            process(lg, name, val, iter)
        end
    end
end


function Base.show(io::IO, lg::WandbLogger)
    str = "WandbLogger(\"$(lg.wrun.project)\", \"$(lg.wrun.name)\", "*
          "id=$(lg.wrun.id), min_level=$(lg.min_level), "*
           "current_step=$(lg.global_step))"
    Base.print(io, str)
    Base.printstyled(io, " @ $(lg.wrun.url)", color = :yellow)
end


export WandbLogger, update_config!, get_config, save

end
