# Integration with Flux.jl

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
