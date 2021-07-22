using FluxTraining

import FluxTraining: Loggables, _combinename

struct WandbBackend <: FluxTraining.LoggerBackend
    logger::WandbLogger
    function WandbBackend(;
        project,
        name,
        min_level = Info,
        step_increment = 1,
        start_step = 0,
        kwargs...,
    )
        return new(WandbLogger(;project = project, name = name,
                                min_level = min_level,
                                step_increment = step_increment,
                                start_step = start_step, kwargs...))
    end
end

Base.show(io::IO, backend::WandbBackend) =
    print(io, "WandbBackend(", show(io, backend.logger), ")")


function FluxTraining.log_to(backend::WandbBackend, value::Loggables.Value, name, i; group = ())
    name = _combinename(name, group)
    log(backend.logger, Dict(name => value.data); step = i)
end


function FluxTraining.log_to(backend::WandbBackend, image::Loggables.Image, name, i; group = ())
    name = _combinename(name, group)
    im = Image(collect(image.data))
    log(backend.logger, Dict(name => im); step = i)
end


function FluxTraining.log_to(backend::WandbBackend, text::Loggables.Text, name, i; group = ())
    name = _combinename(name, group)
    og(backend.logger, Dict(name => text.data); step = i)
end


function FluxTraining.log_to(backend::WandbBackend, hist::Loggables.Histogram, name, i; group=())
    name = _combinename(name, group)
    log(backend.logger, Dict(name => Histogram(hist.data)); step = i)
end


export WandbBackend