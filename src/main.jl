login(; kwargs...) = wandb.login(; kwargs...)

mutable struct WandbLogger <: AbstractLogger
    wrun::PyObject
    step_increment::Int
    global_step::Int
    min_level::LogLevel
end

function WandbLogger(; project, name=nothing, min_level=Info, step_increment=1, start_step=0, kwargs...)
    wrun = nothing
    @static if Sys.iswindows()
        if :settings in keys(kwargs)
            wrun = wandb.init(; project=project, name=name, kwargs...)
        else
            wrun = wandb.init(; project=project, name=name, settings=wandb.Settings(; start_method="thread"), kwargs...)
        end
    else
        wrun = wandb.init(; project=project, name=name, kwargs...)
    end
    if !isnothing(name) && wrun.name != name
        @warn "There is an ongoing wandb run. Please `close` the run before initializing a new one."
    end
    return WandbLogger(wrun, step_increment, start_step, min_level)
end

function Base.show(io::IO, lg::WandbLogger)
    str = "WandbLogger(\"$(lg.wrun.project)\", \"$(lg.wrun.name)\", " *
          "id=$(lg.wrun.id), min_level=$(lg.min_level), " *
          "current_step=$(lg.global_step))"
    Base.print(io, str)
    return Base.printstyled(io, " @ $(lg.wrun.url)"; color=:yellow)
end

increment_step!(lg::WandbLogger, Δ_Step) = lg.global_step += Δ_Step

# https://docs.wandb.ai/guides/track/log
log(lg::WandbLogger, logs::Dict; kwargs...) = lg.wrun.log(logs; kwargs...)

# https://docs.wandb.ai/guides/track/config
update_config!(lg::WandbLogger, dict::Dict; kwargs...) = lg.wrun.config.update(dict; kwargs...)

# https://docs.wandb.ai/ref/python/finish
Base.close(lg::WandbLogger; kwargs...) = lg.wrun.finish(; kwargs...)

function finish(lg::WandbLogger; kwargs...)
    @warn "The desired way to end the run is `close`. Please update your code to use the same" maxlog = 1
    return close(lg; kwargs...)
end

# https://docs.wandb.ai/ref/python/save
save(lg::WandbLogger, file::String; kwargs...) = lg.wrun.save(file; kwargs...)

get_config(lg::WandbLogger) = lg.wrun.config
get_config(lg::WandbLogger, key::String) = get(lg.wrun.config, key)

# Logging Types: Image, Video, Histogram, 3D Objects, PR Curve
## We assume the images to be ordered as per Flux conventions
Image(img::AbstractArray{T,3}; kwargs...) where {T} = wandb.Image(permutedims(img, (3, 1, 2)); kwargs...)
Image(img::AbstractMatrix; kwargs...) = wandb.Image(img; kwargs...)
Image(img::String; kwargs...) = wandb.Image(img; kwargs...)
function Image(img::Any; kwargs...)
    mime_pairs = ((MIME"image/png"(), "png"), (MIME"image/jpeg"(), "jpg"))
    for (mime, ext) in mime_pairs
        showable(mime, img) || continue
        path = joinpath(mktempdir(), "img.$ext") # cleaned up on Julia process exit
        open(path; write=true) do io
            show(io, mime, img)
        end
        return wandb.Image(path; kwargs...)
    end
    error("Could not `show` `img` as any of $(first.(mime_pairs))")
end


Video(vid::AbstractArray{T,4}; kwargs...) where {T} = wandb.Video(permutedims(vid, (4, 3, 2, 1)); kwargs...)
Video(vid::AbstractArray{T,3}; kwargs...) where {T} = wandb.Video(permutedims(vid, (3, 2, 1)); kwargs...)
Video(vid::String; kwargs...) = wandb.Video(vid; kwargs...)

Histogram(x::AbstractArray; kwargs...) = wandb.Histogram(x; kwargs...)

Object3D(path::String) = wandb.Object3D(open(path, 'r'))

function precision_recall(y_test::AbstractVector, y_probs::AbstractVector, labels::AbstractVector)
    return wandb.plots.precision_recall(y_test, y_probs, labels)
end

"""
    version()

Return the Wandb python client version number (i.e., `Wandb.wandb.__version__`).
"""
version() = VersionNumber(map(Base.Fix1(parse, UInt32), split(wandb.__version__, "."))...)


"""
    update_client()

Updates the wandb client
"""
function update_client()
    msg = Wandb.wandb.sdk.internal.update.check_available(wandb.__version__)
    if msg !== nothing
        @info "Trying to update Wandb to the latest stable release"
        run(`$(PyCall.pyprogramname) -m pip install wandb --upgrade`)
        @info "Please restart Julia session to use the updated release"
    else
        @info "No new version of Wandb Client found"
    end
end
