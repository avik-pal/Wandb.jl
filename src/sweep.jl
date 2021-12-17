# Unfortunately the default wandb agent API causes a segfault.

# function sweep(sweep_config::Dict; entity = nothing, project = nothing)
#     return wandb.sweep(sweep_config, entity, project)
# end

# function agent(
#     sweep_id;
#     func = nothing,
#     entity = nothing,
#     project = nothing,
#     count = nothing,
# )
#     return wandb.agent(sweep_id, func, entity, project, count)
# end

mutable struct WandbHyperParameterSweep
    sweep_tag::String
end

WandbHyperParameterSweep() = WandbHyperParameterSweep(randstring(12))

function (hpsweep::WandbHyperParameterSweep)(func, config,
                                             # For Compat with FluxTraining and other Integrations
                                             logger=WandbLogger, args...; func_args=(), func_kwargs=(;), kwargs...)
    lg = logger(args...; tags=[hpsweep.sweep_tag], kwargs...)

    try
        @info "Logging to Wandb" logger = lg

        # The user can pass other global configuration options to the sweep
        update_config!(lg, config)

        res = func(lg, Dict(get_config(lg).__dict__["_items"]), func_args...; func_kwargs...)

        close(lg)

        return res
    catch
        # Close the logger else we have to restart the julia session to get things
        # back into sync
        close(lg)
        rethrow()
    end
end
