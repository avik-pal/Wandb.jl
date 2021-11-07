<<<<<<< HEAD
using Documenter

makedocs(
=======
using Documenter, Wandb

makedocs(
    modules = [Wandb],
    doctest = true,
>>>>>>> ba591a5 (Merge)
    sitename = "Wandb",
    authors = "Avik Pal",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
    ),
    pages = [
        "Home"              => "index.md",
        "QuickStart"        => "quickstart.md",
        "Miscellaneous"     => "misc.md",
        "Examples" => [
            "Getting Started"             => "examples/demo.md",
            "Flux.jl Intergration"        => "examples/flux.md",
            "FluxTraining.jl Integration" => "examples/fluxtraining.md",
            "HyperParameter Sweeps"       => "examples/hparams.md",
            "Artifacts API"               => "examples/artifacts.md",
            "MPI.jl Integration"          => "examples/mpi.md",
        ],
    ],
)

deploydocs(
    repo = "github.com/avik-pal/Wandb.jl.git"
)