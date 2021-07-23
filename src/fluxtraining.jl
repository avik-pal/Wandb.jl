using FluxTraining

import FluxTraining: Loggables, _combinename

struct WandbBackend <: FluxTraining.LoggerBackend
    logger::WandbLogger

    WandbBackend(;kwargs...) = new(WandbLogger(;kwargs...))
end

function Base.show(io::IO, backend::WandbBackend)
    print(io, "WandbBackend(")
    print(io, backend.logger)
    print(io, ")")
end


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


Base.close(backend::WandbBackend) = close(backend.logger)


export WandbBackend