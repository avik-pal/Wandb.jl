using MPI

mutable struct WandbLoggerMPI{L<:Union{Nothing,WandbLogger},C}
    logger::L
    config::C
end

Base.getproperty(wl::WandbLoggerMPI, id) = hasfield(wl, id) ? getfield(wl, id) : getproperty(wl.logger, id)

function WandbLoggerMPI(args...; kwargs...)
    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    size = MPI.Comm_size(comm)

    if rank == 0
        if size == 1
            return WandbLogger(args...; kwargs...)
        else
            return WandbLoggerMPI(WandbLogger(args...; kwargs...), get(kwargs, "config", Dict()))
        end
    else
        return WandbLoggerMPI(nothing, get(kwargs, "config", Dict()))
    end
end

function Base.show(io::IO, ::WandbLoggerMPI{Nothing})
    Base.print(io, "WandbLogger(Non Logging Process)")
end

function Base.show(io::IO, wl::WandbLoggerMPI)
    Base.show(io, wl.logger)
end

function update_config!(lg::WandbLoggerMPI, dict::Dict; kwargs...)
    error("Updating Config when using MPI is not yet supported")
end

for func in (:log, :close)
    @eval begin
        Base.$(func)(wa::WandbLoggerMPI, args...; kwargs...) =
            $(func)(wa.logger, args...; kwargs...)
        
        Base.$(func)(wa::WandbLoggerMPI{Nothing}, args...; kwargs...) =
            nothing
    end
end

for func in (:increment_step!, :finish, :save)
    @eval begin
        $(func)(wa::WandbLoggerMPI, args...; kwargs...) =
            $(func)(wa.logger, args...; kwargs...)
        
        $(func)(wa::WandbLoggerMPI{Nothing}, args...; kwargs...) =
            nothing
    end
end

export WandbLoggerMPI
