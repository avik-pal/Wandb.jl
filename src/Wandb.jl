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

wandb_login(;kwargs...) = wandb.login(;kwargs...)

wandb_run() = wandb.run

# https://docs.wandb.ai/ref/python/init
wandb_init(;kwargs...) = wandb.init(;kwargs...)

# https://docs.wandb.ai/guides/track/log
wandb_log(logs::Dict) = wandb_log(wandb.run, logs)
wandb_log(run, logs::Dict) = run.log(logs)

# https://docs.wandb.ai/guides/track/config
wandb_update_config!(dict::Dict; kwargs...) = wandb_update_config!(wandb.run, dict; kwargs...)
wandb_update_config!(run, dict::Dict; kwargs...) = run.config.update(dict; kwargs...)

# https://docs.wandb.ai/ref/python/finish
wandb_finish(;kwargs...) = wandb_finish(wandb.run; kwargs...)
wandb_finish(run; kwargs...) = run.finish(;kwargs...)

# https://docs.wandb.ai/ref/python/save
wandb_save(;kwargs...) = wandb.save(wandb.run; kwargs...)
wandb_save(run; kwargs...) = run.save(;kwargs...)

wandb_get_config() = wandb_get_config(wandb.run)
wandb_get_config(run) = run.config
wandb_get_config(key::String) = wandb_get_config(wandb.run, key)
wandb_get_config(run, key::String) = get(run.config, key)

const py_wandb = wandb

export py_wandb, wandb_login, wandb_run, wandb_init, wandb_log, wandb_update_config!, wandb_finish, wandb_save, wandb_get_config

end