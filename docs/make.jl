using Documenter

makedocs(
    sitename = "Wandb",
    authors = "Avik Pal",
    push_preview = true,
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