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

    WandbHyperParameterSweep() = new(randstring(12))
end


function (hpsweep::WandbHyperParameterSweep)(
    func,
    config,
    args...;
    func_args = (),
    func_kwargs = (;),
    kwargs...,
)
    lg = WandbLogger(
        args...;
        tags = [hpsweep.sweep_tag],
        kwargs...,
    )

    @info "Logging to Wandb" logger=lg

    # The user can pass other global configuration options to the sweep
    update_config!(lg, config)

    res = func(lg, Dict(get_config(lg).__dict__["_items"]), func_args...; func_kwargs...)

    close(lg)

    return res
end
