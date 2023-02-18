module Wandb

using PyCall, Conda, Random, Requires

const wandb = PyNULL()

function __init__()
    copy!(wandb, pyimport("wandb"))

    @require FluxTraining="7bf95e4d-ca32-48da-9824-f0dc5310474f" begin include("fluxtraining.jl") end

    @require MPI="da04e1cc-30fd-572f-bb4f-1f8673147195" begin include("mpi.jl") end
end

using Base.CoreLogging: CoreLogging, AbstractLogger, LogLevel, Info, handle_message,
                        shouldlog, min_enabled_level, catch_exceptions

# Base functions like `log`, `Image`, etc.
include("main.jl")
# Wandb Artifacts API
include("artifacts.jl")
# AbstractLogger interface
include("corelogging.jl")
# HyperParameter Tuning: Sweep/Agent API
include("sweep.jl")

export WandbLogger, WandbArtifact, WandbHyperParameterSweep, update_config!, get_config,
       save

end
