# Wandb.jl

Unofficial Julia Bindings for [wandb.ai](wandb.ai).

## Installation

```julia
julia> ]
pkg> add https://github.com/avik-pal/Wandb.jl
```

## Quick Start

Follow the [quickstart](https://docs.wandb.ai/quickstart) points 1 and 2 to get started with a Wandb account.

```julia
# Initialize the project
wandb_init(project = "wandb-julia-bindings-testing")

# Logging Values
wandb_log(Dict("accuracy" => 0.9, "loss" => 0.3))

# Tracking Hyperparameters
wandb_update_config!(Dict("dropout" => 0.2))
```

## Complete Example

Example borrowed from [here](https://colab.research.google.com/drive/1aEv8Haa3ppfClcCiC2TB8WLHB4jnY_Ds#scrollTo=-VE3MabfZAcx)

```julia
using Wandb

# Start a new run, tracking hyperparameters in config
wandb_init(project = "wandb-julia-bindings-testing",
           config = Dict("learning_rate" => 0.01,
                         "dropout" => 0.2,
                         "architecture" => "CNN",
                         "dataset" => "CIFAR-100"))

# Simulating the training or evaluation loop
for x ∈ 1:50
    acc = log(1 + x + rand() * wandb_get_config("learning_rate") + rand() + wandb_get_config("dropout"))
    loss = 10 - log(1 + x + rand() + x * wandb_get_config("learning_rate") + rand() + wandb_get_config("dropout"))
    # Log metrics from your script to W&B
    wandb_log(Dict("acc" => acc, "loss" => loss))
end

# Finish the run
wandb_finish()
```

## Using Undocumented Features

Most of the wandb API should be usable through `py_wandb`. In case something isn't working as expected, open an Issue/PR.

## Features with no direct bindings

1. `wandb.agent`
2. `wandb.sweep`
3. Others which I shall implement soon are in the TODO section

NOTE: I personally don't use `1` and `2` much so might not implement them. I am happy to accept PRs for the
      these though.

## TODO:

- [ ] `wandb.watch` for Flux Models
- [ ] Logging Images directly using Images.jl