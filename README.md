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

### v0.4.0

* `Base.log` is no longer exported. Users need to do `Wandb.log` (https://github.com/avik-pal/Wandb.jl/issues/9)
* `FluxMPI` + `Wandb` integration demo updated to the latest API