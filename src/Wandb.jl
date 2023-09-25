module Wandb

using CondaPkg, PythonCall  # Interface with Python
using Random
using Base.CoreLogging: CoreLogging, AbstractLogger, LogLevel, Info, handle_message,
  shouldlog, min_enabled_level, catch_exceptions

const wandb = PythonCall.pynew()
const numpy = PythonCall.pynew()

import PackageExtensionCompat: @require_extensions
function __init__()
  PythonCall.pycopy!(wandb, pyimport("wandb"))
  PythonCall.pycopy!(numpy, pyimport("numpy"))

  @require_extensions

  return
end

# Some Utility Functions
_to_numpy(x::AbstractArray) = numpy.asarray(x)

_to_list(x) = pylist(x)
_to_list(x::AbstractMatrix) = pylist(pylist.(eachrow(x)))

_to_dict(x) = x
_to_dict(x::String) = pystr(x)
_to_dict(x::AbstractArray) = _to_list(x)
_to_dict(d::Dict) = pydict(Dict(k => _to_dict(v) for (k, v) in pairs(d)))

# Base functions like `log`, `Image`, etc.
include("main.jl")
# Wandb Artifacts API
include("artifacts.jl")
# AbstractLogger interface
include("corelogging.jl")
# HyperParameter Tuning: Sweep/Agent API
include("sweep.jl")

# Defined in Extensions
mutable struct WandbLoggerMPI{L <: Union{Nothing, WandbLogger}, C}
  logger::L
  config::C
end

struct WandbBackend
  logger::WandbLogger

  WandbBackend(; kwargs...) = new(WandbLogger(; kwargs...))
end

export WandbLogger, update_config!, get_config
export WandbHyperParameterSweep
export WandbArtifact
export WandbLoggerMPI, WandbBackend

end
