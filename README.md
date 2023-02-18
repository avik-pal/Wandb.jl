# Wandb.jl

[![Latest Docs](https://img.shields.io/badge/docs-latest-blue.svg)](https://avik-pal.github.io/Wandb.jl/dev/)
[![Stable Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://avik-pal.github.io/Wandb.jl/stable/)

Unofficial Julia Bindings for [wandb.ai](https://wandb.ai).

## Installation

To install simply do the following in a Julia REPL

```julia
] add Wandb
```

## Quick Start

Follow the [quickstart](https://docs.wandb.ai/quickstart) points 1 and 2 to get started with a Wandb account.

```julia
using Wandb, Logging

# Initialize the project
lg = WandbLogger(; project = "Wandb.jl", name = nothing)

# Set logger globally / in scope / in combination with other loggers
global_logger(lg)

# Logging Values
Wandb.log(lg, Dict("accuracy" => 0.9, "loss" => 0.3))

# Even more conveniently
@info "metrics" accuracy=0.9 loss=0.3
@debug "metrics" not_print=-1  # Will have to change debug level for this to be logged

# Tracking Hyperparameters
update_config!(lg, Dict("dropout" => 0.2))

# Close the logger
close(lg)  # `finish` works as well but is not a recommended api
```


## Changelog

### v0.5

#### v0.5.0

  * Transition to use `CondaPkg` and `PythonCall`.
  * `save` is no longer exported since the name is too common.
  * `Wandb.finish` has been removed. Use `Base.close` instead.

### v0.4

#### v0.4.4

  * `Base.log` is not extended for `WandbBackend` of `FluxTraining`.

#### v0.4.3

  * `Wandb.Image` now supports any object with a `show(::IO, ::MIME"image/png", img)` (or
    `image/jpeg`) method.

#### v0.4.2

  * `version()` returns a `VersionNumber` instead of a `String`
  * `update_client()` needs to be called to update the wandb client. We no longer check for
    updates by default.

#### v0.4.1

  * The Wandb python client version number is no longer printed during `__init__` (i.e. when
    calling `using Wandb`). Instead, call `Wandb.version()` to see the client version
    number.

#### v0.4.0

  * `Base.log` is no longer exported. Users need to do `Wandb.log`
    (https://github.com/avik-pal/Wandb.jl/issues/9)
  * `FluxMPI` + `Wandb` integration demo updated to the latest API
