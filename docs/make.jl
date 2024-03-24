using Documenter, DocumenterVitepress
using Wandb

makedocs(;
  modules=[Wandb],
  authors="Avik Pal",
  repo="https://github.com/avik-pal/Wandb.jl",
  sitename="Wandb.jl Documentation",
  format=DocumenterVitepress.MarkdownVitepress(;
    repo="github.com/avik-pal/Wandb.jl",
    devurl="dev",
    devbranch="main"
  ),
  pages=[
    "Home" => "index.md",
    "API Reference" => "api.md",
    "Examples" => [
      "Getting Started" => "examples/demo.md",
      "Flux.jl Intergration" => "examples/flux.md",
      "FluxTraining.jl Integration" => "examples/fluxtraining.md",
      "HyperParameter Sweeps" => "examples/hparams.md",
      "Artifacts API" => "examples/artifacts.md",
      "MPI.jl Integration" => "examples/mpi.md"
    ]
  ]
)

deploydocs(;
  repo="github.com/avik-pal/Wandb.jl",
  target="build",
  push_preview=true,
  devbranch="main"
)
