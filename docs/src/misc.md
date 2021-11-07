# Miscellaneous Stuff

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
2. `MPI` --> `WandbLoggerMPI`

---

## Using Undocumented Features

Most of the wandb API should be usable through `Wandb.wandb`. In case something isn't working as expected, open an Issue/PR.

---

## Troubleshooting

1. `Wandb.jl` crashed Julia :( / Long error messages but stuff works :O

It is possible that when creating the first logger instance `wandb` crashes julia or throws a verbose error
about SSL not being present. A workaround to this is to use the env variable `LD_PRELOAD` and point it to
the `libssl.so` library shipped by `conda`. For me it is present in `/mnt/miniconda3/lib/libssl.so`. If you
are using `Conda.jl` installation with `ENV["PYTHON"] = ""` then it should be present inside
`~/.julia/conda/...`.

[Here](https://github.com/JuliaPy/Conda.jl/issues/58) is a documented issue in `PyCall.jl`.

P.S. If anyone knows a proper solution to this problem, please open a PR to update this section.

2. Can't use `Wandb.Histogram` / `FluxTraining.LogHistograms`

Install `numpy`. Make sure to install in the same environment as `PyCall.jl`. This should do it

```julia
using PyCall
run(`$(PyCall.pyprogramname) -m pip install numpy`)
```

3. Can't use `Wandb.Image` / `FluxTraining.LogVisualization`

Install `pillow`. Make sure to install in the same environment as `PyCall.jl`. This should do it

```julia
using PyCall
run(`$(PyCall.pyprogramname) -m pip install pillow`)
```

---