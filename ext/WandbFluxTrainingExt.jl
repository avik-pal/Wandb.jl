module WandbFluxTrainingExt

using FluxTraining, Wandb
import FluxTraining: Loggables, _combinename, cpu

function Base.show(io::IO, backend::Wandb.WandbBackend)
  print(io, "WandbBackend(")
  print(io, backend.logger)
  return print(io, ")")
end

function Base.close(wa::Wandb.WandbBackend, args...; kwargs...)
  return close(wa.logger, args...; kwargs...)
end

for func in (:log, :update_config!, :close, :save, :get_config)
  @eval begin
    function Wandb.$(func)(wa::Wandb.WandbBackend, args...; kwargs...)
      return Wandb.$(func)(wa.logger, args...; kwargs...)
    end
  end
end

function FluxTraining.log_to(backend::Wandb.WandbBackend, value::Loggables.Value, name, i;
    group=())
  name = _combinename(name, group)
  if length(group) == 0
    Wandb.log(backend.logger, Dict(name => cpu(value.data)))
  else
    Wandb.log(backend.logger, Dict(name => cpu(value.data), group[1] => i))
  end
end

function FluxTraining.log_to(backend::Wandb.WandbBackend, image::Loggables.Image, name, i;
    group=())
  name = _combinename(name, group)
  imgs = Image.(collect(image.data))
  if length(group) == 0
    Wandb.log(backend.logger,
      Dict([name * "_$i" => img for (i, img) in enumerate(imgs)]...))
  else
    Wandb.log(backend.logger,
      Dict([name * "_$i" => img for (i, img) in enumerate(imgs)]..., group[1] => i))
  end
end

function FluxTraining.log_to(backend::Wandb.WandbBackend, text::Loggables.Text, name, i;
    group=())
  name = _combinename(name, group)
  if length(group) == 0
    Wandb.log(backend.logger, Dict(name => text.data))
  else
    Wandb.log(backend.logger, Dict(name => text.data, group[i] => i))
  end
end

function FluxTraining.log_to(backend::Wandb.WandbBackend, hist::Loggables.Histogram, name,
    i; group=())
  name = _combinename(name, group)
  if length(group) == 0
    Wandb.log(backend.logger, Dict(name => Histogram(cpu(hist.data))))
  else
    Wandb.log(backend.logger, Dict(name => Histogram(cpu(hist.data)), group[1] => i))
  end
end

end
