# Mostly a blunt copy from CometLogger.jl
# https://github.com/rejuvyesh/CometLogger.jl/blob/master/src/CometLogger.jl
CoreLogging.catch_exceptions(lg::WandbLogger) = false

CoreLogging.min_enabled_level(lg::WandbLogger) = lg.min_level

# For now, log everything that is above the lg.min_level
CoreLogging.shouldlog(lg::WandbLogger, level, _module, group, id) = true

function preprocess(name, val::T, data) where {T}
    if isstructtype(T) && !(val isa PyObject)
        fn = logable_propertynames(val)
        for f in fn
            prop = getfield(val, f)
            preprocess(name * "/$f", prop, data)
        end
    else
        push!(data, name => val)
    end
    return data
end

"""
    logable_propertynames(val::Any)

Returns a tuple with the name of the fields of the structure `val` that
should be logged to Wandb. This function should be overridden when
you want Wandb to ignore some fields in a structure when logging
it. The default behaviour is to return the  same result as `propertynames`.
See also: [`Base.propertynames`](@ref)
"""
logable_propertynames(val::Any) = propertynames(val)

## Default unpacking of key-value dictionaries
function preprocess(name, dict::AbstractDict, data)
    for (key, val) in dict
        # convert any key into a string, via interpolating it
        preprocess("$name/$key", val, data)
    end
    return data
end

# Split complex numbers into real/complex pairs
function preprocess(name, val::Complex, data)
    return push!(data, name * "/re" => real(val), name * "/im" => imag(val))
end

function process(lg::WandbLogger, name::AbstractString, obj, step::Int)
    return log(lg, Dict(name => obj); step=step)
end

function CoreLogging.handle_message(lg::WandbLogger, level, message, _module, group, id,
                                    file, line; kwargs...)
    i_step = lg.step_increment # :log_step_increment default value

    if !isempty(kwargs)
        data = Vector{Pair{String, Any}}()
        # ∀ (k-v) pairs, decompose values into objects that can be serialized
        for (key, val) in pairs(kwargs)
            # special key describing step increment
            if key == :log_step_increment
                i_step = val
                continue
            end
            preprocess(message * "/$key", val, data)
        end
        iter = increment_step!(lg, i_step)
        for (name, val) in data
            process(lg, name, val, iter)
        end
    end
end
