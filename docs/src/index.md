# Wandb.jl

Unofficial Julia Bindings for [wandb.ai](https://wandb.ai).

## Installation

For stable release:

```julia
] add Wandb
```

For the `main` branch:

```julia
] add Wandb#main
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
close(lg)
```

## Examples

To see the logging in action go [here](https://wandb.ai/avikpal/Wandb.jl). Detailed code
for these examples can be accessed via the navigation menu.

## Running into Issues

Please have a look at the `Miscellaneous` Section to see if it solves your issue. If not,
please report bugs using GitHub Issues. For usage questions post them on Discourse
(`@avik-pal`) or Julia Slack (#helpdesk channel) (`@avikpal`) tagging me.
