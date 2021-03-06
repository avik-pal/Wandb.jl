using .MPI

mutable struct WandbLoggerMPI{L<:Union{Nothing,WandbLogger},C}
    logger::L
    config::C
end

function Base.getproperty(wl::WandbLoggerMPI, id::Symbol)
    return hasfield(typeof(wl), id) ? getfield(wl, id) : getproperty(wl.logger, id)
end

function WandbLoggerMPI(args...; name::Union{Nothing,String}=nothing, group::Union{Nothing,String}=nothing, kwargs...)
    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    size = MPI.Comm_size(comm)

    if isnothing(group)
        if rank == 0
            if size == 1
                return WandbLogger(args...; name=name, kwargs...)
            else
                return WandbLoggerMPI(WandbLogger(args...; name=name, kwargs...), get(kwargs, :config, Dict()))
            end
        else
            return WandbLoggerMPI(nothing, get(kwargs, :config, Dict()))
        end
    else
        if !isnothing(name)
            name = name * "_rank_$rank"
        end
        return WandbLogger(args...; name=name, group=group, kwargs...)
    end
end

function Base.show(io::IO, ::WandbLoggerMPI{Nothing})
    return Base.print(io, "WandbLogger(Non Logging Process)")
end

function Base.show(io::IO, wl::WandbLoggerMPI)
    return Base.show(io, wl.logger)
end

function update_config!(lg::WandbLoggerMPI, dict::Dict; kwargs...)
    # I forgot why I was throwing this error :'(
    return error("Updating Config when using MPI is not yet supported")
end

get_config(lg::WandbLoggerMPI, key::String) = get(lg.config, key, nothing)
get_config(lg::WandbLoggerMPI) = lg.config

for func in (:log, :close)
    @eval begin
        Base.$(func)(wa::WandbLoggerMPI, args...; kwargs...) = $(func)(wa.logger, args...; kwargs...)

        Base.$(func)(wa::WandbLoggerMPI{Nothing}, args...; kwargs...) = nothing
    end
end

for func in (:increment_step!, :finish, :save)
    @eval begin
        $(func)(wa::WandbLoggerMPI, args...; kwargs...) = $(func)(wa.logger, args...; kwargs...)

        $(func)(wa::WandbLoggerMPI{Nothing}, args...; kwargs...) = nothing
    end
end

export WandbLoggerMPI
