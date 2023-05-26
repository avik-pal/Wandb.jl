# Integration with FluxTraining.jl

We have bindings in the form of `WandbBackend` which can be used as a dropin replacement for the
default `TensorboardBackend`. Just ensure that `FluxTraining.jl` is installed and loaded explicitly.

Let's go through the
[FluxTraining.jl MNIST](https://github.com/FluxML/FluxTraining.jl/blob/master/docs/tutorials/mnist.ipynb)
example and update it to use Wandb.


```julia
using MLUtils: splitobs, unsqueeze
using MLDatasets: MNIST
using Flux
using Flux: onehotbatch
using Flux.Data: DataLoader
using FluxTraining
using Wandb

# import data
data = MNIST(:train)[:]

const LABELS = 0:9

# unsqueeze to reshape from (28, 28, numobs) to (28, 28, 1, numobs)
function preprocess((data, targets))
    return unsqueeze(data, 3), onehotbatch(targets, LABELS)
end


# traindata and testdata contain both inputs (pixel values) and targets (correct labels)
traindata = MNIST(Float32, :train)[:] |> preprocess
testdata = MNIST(Float32, :test)[:] |> preprocess

# create iterators
trainiter, testiter = DataLoader(traindata, batchsize=128), DataLoader(testdata, batchsize=256);

# create model and optimizer
model = Chain(
    Conv((3, 3), 1 => 16, relu, pad = 1, stride = 2),
    Conv((3, 3), 16 => 32, relu, pad = 1),
    GlobalMeanPool(),
    Flux.flatten,
    Dense(32, 10),
)
lossfn = Flux.Losses.logitcrossentropy
optimizer = Flux.ADAM();

# prepare learner
logwandb = LogMetrics(WandbBackend(project = "Wandb.jl", 
                                    name = "fluxtrainingjl-integration-$(now())"))
learner = Learner(model, lossfn; callbacks=[ToGPU(), Metrics(accuracy)], optimizer)

# fit model
FluxTraining.fit!(learner, 10, (trainiter, testiter))
```
