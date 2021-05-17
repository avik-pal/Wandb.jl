# Wandb.jl

Unofficial Julia Bindings for [wandb.ai](https://wandb.ai).

## Installation

```julia
julia> ]
pkg> add https://github.com/avik-pal/Wandb.jl
```

---

## Quick Start

Follow the [quickstart](https://docs.wandb.ai/quickstart) points 1 and 2 to get started with a Wandb account.

```julia
# Initialize the project
wandb_init(project = "Wandb.jl")

# Logging Values
wandb_log(Dict("accuracy" => 0.9, "loss" => 0.3))

# Tracking Hyperparameters
wandb_update_config!(Dict("dropout" => 0.2))
```

---

## Examples

Runs demonstrating these examples are available [here](https://wandb.ai/avikpal/Wandb.jl).

<details><summary>Dummy Code from Wandb tutorial</summary>
<p>
Example borrowed from <a href="https://colab.research.google.com/drive/1aEv8Haa3ppfClcCiC2TB8WLHB4jnY_Ds#scrollTo=-VE3MabfZAcx">here</a>.

```julia
using Wandb, Dates

# Start a new run, tracking hyperparameters in config
wandb_init(project = "Wandb.jl",
           name = "wandbjl-demo-$(now())",
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

wandb_init(
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
        batchsize = wandb_get_config("batchsize"),
        shuffle = true,
    )
    test_loader = DataLoader((xtest, ytest), batchsize = wandb_get_config("batchsize"))

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
    wandb_update_config!(update_params)

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

    ###########################
    # Wandb # Set up the logger
    ###########################
    wblogger = wandb_flux_watch(ps, log_freq = 500)

    ## Optimizer
    opt = ADAM(wandb_get_config("learning_rate"))

    ## Training
    for epoch = 1:wandb_get_config("epochs")
        for (x, y) in train_loader
            x, y = device(x), device(y) # transfer data to device
            gs = gradient(() -> logitcrossentropy(model(x), y), ps) # compute gradient
            Flux.Optimise.update!(opt, ps, gs) # update parameters

            ##########################################
            # Wandb # Log the gradients and parameters
            ##########################################
            wandb_log(wblogger, cpu; parameters = ps, gradients = gs, commit = false)
        end

        # Report on train and test
        train_loss, train_acc = loss_and_accuracy(train_loader, model, device)
        test_loss, test_acc = loss_and_accuracy(test_loader, model, device)

        ###################################
        # Wandb # Log the loss and accuracy
        ###################################
        wandb_log(
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
wandb_finish()
```
</p>
</details>

---

## Available Logging Objects

1. `wandb_image`
2. `wandb_video`
3. `wandb_histogram`
4. `wandb_object3D`
5. `wandb_precision_recall_curve`
6. `FluxWandbLogger`

---

## Using Undocumented Features

Most of the wandb API should be usable through `py_wandb`. In case something isn't working as expected, open an Issue/PR.

---

## Features with no direct bindings

1. `wandb.agent`
2. `wandb.sweep`

NOTE: I personally don't use `1` and `2` much so might not implement them. I am happy to accept PRs for the
      these though.
