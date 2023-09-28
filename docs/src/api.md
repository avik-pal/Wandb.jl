```@meta
CurrentModule = Wandb
```

# API Reference

## Core Functionalities

For a lot of these functions, the [official WanDB docs](https://docs.wandb.ai/) can provide
more comprehensive details.

```@docs
WandbLogger
Wandb.increment_step!
update_config!
get_config
Wandb.save
Wandb.version
Wandb.update_client
Wandb.log
Wandb.logable_propertynames
Base.close
```

## Plotting

```@docs
Wandb.plot_line
Wandb.plot_scatter
Wandb.plot_histogram
Wandb.plot_bar
Wandb.plot_line_series
```

!!! note

    We don't provide direct bindings for the other plotting functions. PRs implementing
    these are welcome.

## Loggable Objects

```@docs
Wandb.Image
Wandb.Video
Wandb.Histogram
Wandb.Object3D
Wandb.Table
```

## Artifacts

```@docs
WandbArtifact
```

## Hyper Parameter Sweep

```@docs
WandbHyperParameterSweep
```

## Index

```@index
Pages = ["api.md"]
```