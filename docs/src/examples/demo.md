# Getting Started Tutorial

Example borrowed from [here](https://colab.research.google.com/drive/1aEv8Haa3ppfClcCiC2TB8WLHB4jnY_Ds#scrollTo=-VE3MabfZAcx)

```julia
using Wandb, Dates, Logging

# Start a new run, tracking hyperparameters in config
lg = WandbLogger(project = "Wandb.jl", name = "wandbjl-demo-$(now())",
                 config = Dict("learning_rate" => 0.01, "dropout" => 0.2,
                               "architecture" => "CNN", "dataset" => "CIFAR-100"))

# Use LoggingExtras.jl to log to multiple loggers together
global_logger(lg)

# Simulating the training or evaluation loop
for x ∈ 1:50
    acc = Wandb.log(1 + x + rand() * get_config(lg, "learning_rate") + rand() +
                    get_config(lg, "dropout"))
    loss = 10 - Wandb.log(1 + x + rand() + x * get_config(lg, "learning_rate") + rand() +
                          get_config(lg, "dropout"))
    # Log metrics from your script to W&B
    @info "metrics" accuracy=acc loss=loss
end

# Finish the run
close(lg)
```
