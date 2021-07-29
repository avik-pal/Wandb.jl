module Wandb

using PyCall, Conda, Requires

const wandb = PyNULL()

function __init__()
    copy!(wandb, pyimport("wandb"))
    @info "Using Wandb version $(wandb.__version__)"

    @require FluxTraining="7bf95e4d-ca32-48da-9824-f0dc5310474f" begin
        include("fluxtraining.jl")
    end
end

using Base.CoreLogging:
    CoreLogging,
    AbstractLogger,
    LogLevel,
    Info,
    handle_message,
    shouldlog,
    min_enabled_level,
    catch_exceptions

    
# Base functions like `log`, `Image`, etc.
include("main.jl")
# Wandb Artifacts API
include("artifacts.jl")
# AbstractLogger interface
include("corelogging.jl")


export WandbLogger, WandbArtifact, update_config!, get_config, save

end
