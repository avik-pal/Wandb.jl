using .FluxTraining

import .FluxTraining: Loggables, _combinename, cpu

struct WandbBackend <: FluxTraining.LoggerBackend
  logger::WandbLogger

  WandbBackend(; kwargs...) = new(WandbLogger(; kwargs...))
end

function Base.show(io::IO, backend::WandbBackend)
  print(io, "WandbBackend(")
  print(io, backend.logger)
  return print(io, ")")
end

Base.close(wa::WandbBackend, args...; kwargs...) = close(wa.logger, args...; kwargs...)

for func in (:log, :update_config!, :finish, :save, :get_config)
  @eval begin function $(func)(wa::WandbBackend, args...; kwargs...)
    return $(func)(wa.logger, args...; kwargs...)
  end end
end

function FluxTraining.log_to(backend::WandbBackend, value::Loggables.Value, name, i;
                             group=())
  name = _combinename(name, group)
  if length(group) == 0
    log(backend.logger, Dict(name => cpu(value.data)))
  else
    log(backend.logger, Dict(name => cpu(value.data), group[1] => i))
  end
end

function FluxTraining.log_to(backend::WandbBackend, image::Loggables.Image, name, i;
                             group=())
  name = _combinename(name, group)
  imgs = Image.(collect(image.data))
  if length(group) == 0
    log(backend.logger, Dict([name * "_$i" => img for (i, img) in enumerate(imgs)]...))
  else
    log(backend.logger,
        Dict([name * "_$i" => img for (i, img) in enumerate(imgs)]..., group[1] => i))
  end
end

function FluxTraining.log_to(backend::WandbBackend, text::Loggables.Text, name, i; group=())
  name = _combinename(name, group)
  if length(group) == 0
    log(backend.logger, Dict(name => text.data))
  else
    log(backend.logger, Dict(name => text.data, group[i] => i))
  end
end

function FluxTraining.log_to(backend::WandbBackend, hist::Loggables.Histogram, name, i;
                             group=())
  name = _combinename(name, group)
  if length(group) == 0
    log(backend.logger, Dict(name => Histogram(cpu(hist.data))))
  else
    log(backend.logger, Dict(name => Histogram(cpu(hist.data)), group[1] => i))
  end
end

export WandbBackend
