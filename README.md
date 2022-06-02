# Wandb.jl

[![Latest Docs](https://img.shields.io/badge/docs-latest-blue.svg)](https://avik-pal.github.io/Wandb.jl/dev/)
[![Stable Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://avik-pal.github.io/Wandb.jl/stable/)

Unofficial Julia Bindings for [wandb.ai](https://wandb.ai).

## Installation

To install simply do the following in a Julia REPL

```julia
] add Wandb
```

## Changelog

### v0.4.4

* `Base.log` is not extended for `WandbBackend` of `FluxTraining`.

### v0.4.3

* `Wandb.Image` now supports any object with a `show(::IO, ::MIME"image/png", img)` (or `image/jpeg`) method.

### v0.4.2

* `version()` returns a `VersionNumber` instead of a `String`
* `update_client()` needs to be called to update the wandb client. We no longer check for updates by default.

### v0.4.1

* The Wandb python client version number is no longer printed during `__init__` (i.e. when calling `using Wandb`). Instead, call `Wandb.version()` to see the client version number.

### v0.4.0

* `Base.log` is no longer exported. Users need to do `Wandb.log` (https://github.com/avik-pal/Wandb.jl/issues/9)
* `FluxMPI` + `Wandb` integration demo updated to the latest API
