module Wandb

using CondaPkg, PythonCall  # Interface with Python
using Random
using Requires

using Base.CoreLogging: CoreLogging, AbstractLogger, LogLevel, Info, handle_message,
                        shouldlog, min_enabled_level, catch_exceptions

const wandb = PythonCall.pynew()
const numpy = PythonCall.pynew()

function __init__()
  PythonCall.pycopy!(wandb, pyimport("wandb"))
  PythonCall.pycopy!(numpy, pyimport("numpy"))

  # @require FluxTraining="7bf95e4d-ca32-48da-9824-f0dc5310474f" begin include("fluxtraining.jl") end

  # @require MPI="da04e1cc-30fd-572f-bb4f-1f8673147195" begin include("mpi.jl") end

  return
end

# Some Utility Functions
_to_numpy(x::AbstractArray) = numpy.asarray(x)
_to_list(x) = pylist(x)
_to_list(x::AbstractMatrix) = pylist(pylist.(eachrow(x)))

# Base functions like `log`, `Image`, etc.
include("main.jl")
# # Wandb Artifacts API
# include("artifacts.jl")
# AbstractLogger interface
include("corelogging.jl")
# # HyperParameter Tuning: Sweep/Agent API
# include("sweep.jl")

export WandbLogger, update_config!, get_config
# export WandbLogger, WandbArtifact, WandbHyperParameterSweep, update_config!, get_config,
#        save

end
