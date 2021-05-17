module Wandb

using PyCall, Conda

const wandb = PyNULL()

function __init__()
    try
        copy!(wandb, pyimport("wandb"))
    catch
        Conda.pip("install", "wandb")
        copy!(wandb, pyimport("wandb"))
    end
end

wandb_login(; kwargs...) = wandb.login(; kwargs...)

wandb_run() = wandb.run

# https://docs.wandb.ai/ref/python/init
wandb_init(; kwargs...) = wandb.init(; kwargs...)

# https://docs.wandb.ai/guides/track/log
wandb_log(logs::Dict; kwargs...) = wandb_log(wandb.run, logs; kwargs...)
wandb_log(run, logs::Dict; kwargs...) = run.log(logs; kwargs...)

# https://docs.wandb.ai/guides/track/config
wandb_update_config!(dict::Dict; kwargs...) =
    wandb_update_config!(wandb.run, dict; kwargs...)
wandb_update_config!(run, dict::Dict; kwargs...) = run.config.update(dict; kwargs...)

# https://docs.wandb.ai/ref/python/finish
wandb_finish(; kwargs...) = wandb_finish(wandb.run; kwargs...)
wandb_finish(run; kwargs...) = run.finish(; kwargs...)

# https://docs.wandb.ai/ref/python/save
wandb_save(; kwargs...) = wandb.save(wandb.run; kwargs...)
wandb_save(run; kwargs...) = run.save(; kwargs...)

wandb_get_config() = wandb_get_config(wandb.run)
wandb_get_config(run) = run.config
wandb_get_config(key::String) = wandb_get_config(wandb.run, key)
wandb_get_config(run, key::String) = get(run.config, key)

# Logging Types: Image, Video, Histogram, 3D Objects, PR Curve
wandb_image(img::AbstractMatrix; kwargs...) =
    wandb.Image(permutedims(img, (2, 1)); kwargs...)
wandb_image(img::String; kwargs...) = wandb.Image(img; kwargs...)

wandb_video(vid::AbstractArray{T,3}; kwargs...) where {T} =
    wandb.Video(permutedims(vid, (3, 2, 1)); kwargs...)
wandb_video(vid::String; kwargs...) = wandb.Video(vid; kwargs...)

wandb_histogram(x::AbstractArray; kwargs...) = wandb.Histogram(x; kwargs...)

wandb_object3D(path::String) = wandb.Object3D(open(path, 'r'))

wandb_precision_recall_curve(
    y_test::AbstractVector,
    y_probs::AbstractVector,
    labels::AbstractVector,
) = wandb.plots.precision_recall(y_test, y_probs, labels)

# Framework Integrations
abstract type WandbIntegrations end

## Flux.jl
mutable struct FluxWandbLogger{K} <: WandbIntegrations
    keys::K
    log_freq::Int
    counter::Int
end

function wandb_flux_watch(ps; log_freq::Int = 1000)
    keys = IdDict()
    for (i, p) in enumerate(ps)
        keys[p] = i
    end
    return FluxWandbLogger(keys, log_freq, 0)
end

function wandb_log(
    logger::FluxWandbLogger,
    device = identity;
    run = nothing,
    parameters = nothing,
    gradients = nothing,
    kwargs...,
)
    logger.counter += 1
    if logger.counter % logger.log_freq == 1
        run = isnothing(run) ? wandb.run : run
        agg_dict = Dict()
        if !isnothing(parameters)
            for ps in parameters
                agg_dict["Parameters/$(logger.keys[ps])"] = wandb_histogram(device(ps))
            end
        end
        if !isnothing(gradients)
            for ps in gradients.params
                agg_dict["Gradients/$(logger.keys[ps])"] =
                    wandb_histogram(device(gradients[ps]))
            end
        end
        length(agg_dict) >= 1 && wandb_log(run, agg_dict; kwargs...)
    end
    return nothing
end

const py_wandb = wandb

export py_wandb,
    wandb_login,
    wandb_run,
    wandb_init,
    wandb_log,
    wandb_update_config!,
    wandb_finish,
    wandb_save,
    wandb_get_config,
    wandb_image,
    wandb_video,
    wandb_histogram,
    wandb_object3D,
    wandb_flux_watch

end
