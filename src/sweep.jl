# Unfortunately the default wandb agent API doesn't work with Julia.
"""
    WandbHyperParameterSweep()

Create a Wandb Hyperparameter Sweep. Unlike the `wandb.agent` API, this API needs to be
manually combined with some Hyper Parameter Optimization package like `HyperOpt.jl`.

See the tutorials for more details.
"""
struct WandbHyperParameterSweep
  sweep_tag::String
  WandbHyperParameterSweep() = new(randstring(12))
end

function (hpsweep::WandbHyperParameterSweep)(func, cfg,
                                             # For Compat with FluxTraining and other Integrations
                                             logger=WandbLogger, args...; config = nothing,
                                             func_args=(), func_kwargs=(;), kwargs...)
  lg = logger(args...; tags=[hpsweep.sweep_tag], kwargs...)

  try
    @info "Logging to Wandb" logger=lg

    # The user can pass other global configuration options to the sweep
    if config !== nothing
      config = merge(config, cfg)
    else
      config = cfg
    end

    update_config!(lg, config)

    res = func(lg, config, func_args...; func_kwargs...)

    close(lg)

    return res
  catch
    # Close the logger else we have to restart the julia session to get things
    # back into sync
    close(lg)
    rethrow()
  end
end
