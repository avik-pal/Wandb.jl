# Wandb.jl

Unofficial Julia Bindings for [wandb.ai](https://wandb.ai).

## Installation

```julia
] add https://github.com/avik-pal/Wandb.jl
```

---

## Quick Start

Follow the [quickstart](https://docs.wandb.ai/quickstart) points 1 and 2 to get started with a Wandb account.

```julia
# Initialize the project
lg = WandbLogger(project = "Wandb.jl", name = nothing)

# Set logger globally / in scope / in combination with other loggers
global_logger(lg)

# Logging Values
log(lg, Dict("accuracy" => 0.9, "loss" => 0.3))

# Even more conveniently
@info "metrics" accuracy=0.9 loss=0.3
@debug "metrics" not_print=-1  # Will have to change debug level for this to be logged

# Tracking Hyperparameters
update_config!(lg, Dict("dropout" => 0.2))

# Close the logger
close(lg)  # `finish` works as well but is not a recommended api
```

---

## Examples

Runs demonstrating these examples are available [here](https://wandb.ai/avikpal/Wandb.jl).

<details><summary>Dummy Code from Wandb tutorial</summary>
<p>
Example borrowed from <a href="https://colab.research.google.com/drive/1aEv8Haa3ppfClcCiC2TB8WLHB4jnY_Ds#scrollTo=-VE3MabfZAcx">here</a>.

```julia
using Wandb, Dates, Logging

# Start a new run, tracking hyperparameters in config
lg = WandbLogger(project = "Wandb.jl",
                 name = "wandbjl-demo-$(now())",
                 config = Dict("learning_rate" => 0.01,
                               "dropout" => 0.2,
                               "architecture" => "CNN",
                               "dataset" => "CIFAR-100"))

# Use LoggingExtras.jl to log to multiple loggers together
global_logger(lg)

# Simulating the training or evaluation loop
for x ∈ 1:50
    acc = log(1 + x + rand() * get_config(lg, "learning_rate") + rand() + get_config(lg, "dropout"))
    loss = 10 - log(1 + x + rand() + x * get_config(lg, "learning_rate") + rand() + get_config(lg, "dropout"))
    # Log metrics from your script to W&B
    @info "metrics" accuracy=acc loss=loss
end

# Finish the run
close(lg)
```
</p>
</details>

<details><summary>Flux.jl Demo<br></summary>
<p>

Using `Wandb.jl` in existing Flux workflows is pretty easy. Let's go through the <a href="https://github.com/FluxML/model-zoo/blob/master/vision/mlp_mnist/mlp_mnist.jl">mlp_mnist</a> demo in Flux model-zoo and update it to use Wandb. Firstly, use <a href="https://github.com/FluxML/model-zoo/tree/master/vision/mlp_mnist">this environment</a> and add `Wandb.jl` to it.

```julia
using Flux, Statistics
using Flux.Data: DataLoader
using Flux: onehotbatch, onecold, @epochs
using Flux.Losses: logitcrossentropy
using CUDA
using MLDatasets
using Wandb
using Dates

lg = WandbLogger(
    project = "Wandb.jl",
    name = "fluxjl-integration-$(now())",
    config = Dict(
        "learning_rate" => 3e-4,
        "batchsize" => 256,
        "epochs" => 100,
        "dataset" => "MNIST",
        "use_cuda" => true,
    ),
)

global_logger(lg)

##################################################################################
# Wandb # Instead of passing arguments around we will use the global configuration
# Wandb # file from Wandb
##################################################################################
function getdata(device)
    ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"

    # Loading Dataset	
    xtrain, ytrain = MLDatasets.MNIST.traindata(Float32)
    xtest, ytest = MLDatasets.MNIST.testdata(Float32)

    # Reshape Data in order to flatten each image into a linear array
    xtrain = Flux.flatten(xtrain)
    xtest = Flux.flatten(xtest)

    # One-hot-encode the labels
    ytrain, ytest = onehotbatch(ytrain, 0:9), onehotbatch(ytest, 0:9)

    # Create DataLoaders (mini-batch iterators)
    train_loader = DataLoader(
        (xtrain, ytrain),
        batchsize = get_config(lg, "batchsize"),
        shuffle = true,
    )
    test_loader = DataLoader((xtest, ytest), batchsize = get_config(lg, "batchsize"))

    return train_loader, test_loader
end

build_model(; imgsize = (28, 28, 1), nclasses = 10) =
    Chain(Dense(prod(imgsize), 32, relu), Dense(32, nclasses))

function loss_and_accuracy(data_loader, model, device)
    acc = 0
    ls = 0.0f0
    num = 0
    for (x, y) in data_loader
        x, y = device(x), device(y)
        ŷ = model(x)
        ls += logitcrossentropy(model(x), y, agg = sum)
        acc += sum(onecold(cpu(model(x))) .== onecold(cpu(y)))
        num += size(x, 2)
    end
    return ls / num, acc / num
end

#################################################################
# Wandb # If any paramters need to be updated pass them as a Dict
#################################################################
function train(update_params::Dict = Dict())
    #################################
    # Wandb # Update config if needed
    #################################
    update_config!(lg, update_params)

    if CUDA.functional() && wandb_get_config("use_cuda")
        @info "Training on CUDA GPU"
        CUDA.allowscalar(false)
        device = gpu
    else
        @info "Training on CPU"
        device = cpu
    end

    # Create test and train dataloaders
    train_loader, test_loader = getdata(device)

    # Construct model
    model = build_model() |> device
    ps = Flux.params(model) # model's trainable parameters

    ## Optimizer
    opt = ADAM(get_config(lg, "learning_rate"))

    ## Training
    for epoch = 1:get_config(lg, "epochs")
        for (x, y) in train_loader
            x, y = device(x), device(y) # transfer data to device
            gs = gradient(() -> logitcrossentropy(model(x), y), ps) # compute gradient
            Flux.Optimise.update!(opt, ps, gs) # update parameters

            ##########################################
            # Wandb # Log the gradients and parameters
            ##########################################
            log(wblogger, cpu; parameters = ps, gradients = gs, commit = false)
        end

        # Report on train and test
        train_loss, train_acc = loss_and_accuracy(train_loader, model, device)
        test_loss, test_acc = loss_and_accuracy(test_loader, model, device)

        ###################################
        # Wandb # Log the loss and accuracy
        ###################################
        log(
            lg,
            Dict(
                "Training/Loss" => train_loss,
                "Training/Accuracy" => train_acc,
                "Testing/Loss" => test_loss,
                "Testing/Accuracy" => test_acc,
            ),
        )

        println("Epoch=$epoch")
        println("  train_loss = $train_loss, train_accuracy = $train_acc")
        println("  test_loss = $test_loss, test_accuracy = $test_acc")
    end
end

### Run training 
train()

################################
# Wandb # Finish the Current Run
################################
close(lg)
```
</p>
</details>

<details><summary>FluxTraining.jl Demo<br></summary>
<p>
We have bindings in the form of `WandbBackend` which can be used as a dropin replacement for the
default `TensorboardBackend`. Just ensure that `FluxTraining.jl` is installed prior to loading
this package.
</p>
</details>

---

## Available Logging Objects

1. `Image`
2. `Video`
3. `Histogram`
4. `Object3D`
5. `precision_recall`

NOTE: These are not exported since these names are too generic.

---

## Third Party Integrations

1. `FluxTraining.jl` --> `WandbBackend`

---

## Using Undocumented Features

Most of the wandb API should be usable through `Wandb.wandb`. In case something isn't working as expected, open an Issue/PR.

---

## TODO

1. `wandb.agent`
2. `wandb.sweep`
3. `Images.jl` dispatch for `Image`