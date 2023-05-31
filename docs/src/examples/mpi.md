# MPI.jl Integration

For this example we will use the [FluxMPI.jl](https://github.com/avik-pal/FluxMPI.jl) package which adds Multi-GPU/Node Training support for Flux.jl using MPI.jl

```julia
using Flux, FluxMPI, CUDA, Dates, Wandb,  Zygote

# Step 1: Initialize FluxMPI. Not doing this will segfault your code
FluxMPI.Init()
CUDA.allowscalar(false)

lg = WandbLoggerMPI(project = "Wandb.jl",
                    name = "mpijl-demo-$(now())")

# Step 2: Sync Model Parameters
model = Chain(Dense(1, 2, tanh), Dense(2, 1)) |> gpu
ps = Flux.params(model)
FluxMPI.synchronize!(model; root_rank = 0)

# It is the user's responsibility to partition the data across the processes
# In this case, we are training on a total of 16 * <np> samples
x = rand(1, 16) |> gpu
y = x .^ 2
dataloader = Flux.DataLoader((x, y), batchsize = 16)

# Step 3: Wrap the optimizer in DistributedOptimizer
#         Scale the learning rate by the number of workers (`total_workers()`).
opt = Flux.ADAM(0.001)

function loss(x_, y_)
    l = sum(abs2, model(x_) .- y_)
    Zygote.@ignore Wandb.log(lg, Dict("loss" => l))
    return l
end

for epoch in 1:100
    Flux.Optimise.train!(loss, ps, dataloader, opt)
end

# Finish the run
close(lg)
```

The main points when using MPI and Wandb are:

1. `FluxMPI.Init()` must be called before `WandbLoggerMPI` is called.
2. The `config` cannot be updated after `WandbLoggerMPI` is initialized, i.e. `update_config!` won't work.
3. Logging is done the following manner:
   1. If `group` kwarg is not passed/ is `nothing`: All the logging is done by the process with `rank = 0`.
   2. If `group` is set to a string: Look at https://docs.wandb.ai/guides/track/advanced/grouping for more details. (The rank of the processes are appended to the `name` if set)

The code should be run using `mpiexecjl -n 3 julia <script>.jl`.