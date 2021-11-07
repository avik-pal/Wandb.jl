# Hyperparameter Sweeps

We currently don't support Wandb Agents API since it leads to segfaults. Instead we recommend users
to install `Hyperopt.jl` or any other HyperParameter Optimization Library. The resultant Wandb logs
aren't as neat as the official sweeps but do get the job done.

```julia
using Hyperopt
using Wandb

f(x, a, b; c) =
    sum(@. x + (a - 3) ^ 2 + (b ? 10 : 20) + (c - 100) ^ 2) # Function to minimize

# This function dispatch must be present
# `lg` can be `WandbBackend` if using that with HyperParameter Sweep
function f(lg::WandbLogger, config::Dict)
    res = f(config["x"], config["a"], config["b"]; c = config["c"])
    log(lg, Dict("result" => res))
    return res
end

hpsweep = WandbHyperParameterSweep()

# Main macro. The first argument to the for loop is always interpreted as the number of iterations
ho = @hyperopt for i=50,
            sampler = RandomSampler(), # This is default if none provided
            a = LinRange(1,5,1000),
            b = [true, false],
            c = exp10.(LinRange(-1,3,1000))
    hpsweep(f, Dict("a" => a, "b" => b, "c" => c),
            project = "Wandb.jl",
            config = Dict("x" => 100))
end
```

After this is done, we need to do some manual tweaking in the Wandb UI to get a clean
visualization. First, filter the runs using the tag in `hpsweep`. Then just add a
`Parallel Coordinates` plot with the hyperparameters.

![Parallel Coordinates Plot](https://i.imgur.com/89RtziT.png)
