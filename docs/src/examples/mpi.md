# MPI.jl Integration

For this example we will use the [FluxMPI.jl](https://github.com/avik-pal/FluxMPI.jl) package which adds Multi-GPU/Node Training support for Flux.jl using MPI.jl

```julia
using Flux, FluxMPI, MPI, Zygote, CUDA, Wandb, Dates

MPI.Init()
CUDA.allowscalar(false)

lg = WandbLoggerMPI(project = "Wandb.jl",
                    name = "mpijl-demo-$(now())")

total_gpus = length(CUDA.devices())
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
size = MPI.Comm_size(comm)

model = Chain(Dense(1, 2, tanh), Dense(2, 1))

model_dp = DataParallelFluxModel(
    model,
    [i % total_gpus for i = 1:MPI.Comm_size(MPI.COMM_WORLD)],
)

ps = Flux.params(model_dp)

x = rand(1, 64) |> gpu
y = x .^ 2

dataloader = DataParallelDataLoader((x, y), batchsize = 16)

function loss(x_, y_)
    loss = sum(abs2, model_dp(x_) .- y_)
    Zygote.@ignore log(lg, Dict("loss" => loss))
    return loss
end

for epoch in 1:100
    if rank == 0
        @info "epoch = $epoch" 
    end
    Flux.Optimise.train!(loss, ps, dataloader, Flux.ADAM(0.001))
end
```

The main points when using MPI and Wandb are:

1. `MPI.Init()` must be called before `WandbLoggerMPI` is called.
2. The `config` cannot be updated after `WandbLoggerMPI` is initialized, i.e. `update_config!` won't work.
3. All the logging is done by the process with `rank = 0`. We hope to have better synchronization in the future.

The code should be run using `mpiexecjl -n 3 julia <script>.jl`.