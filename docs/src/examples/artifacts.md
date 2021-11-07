# Wandb Artifacts

All the methods listed in https://docs.wandb.ai/ref/python/artifact can be used by passing
a `WandbArtifact` instance as the first argument. Additionally, `log` should be used instead
of `log_artifact` function.

NOTE: These functions are not exported. So use them as `Wandb.<function>(::WandbArtifact, ...)`

### Example Usage:

```julia
using Wandb

lg = WandbLogger(project = "Wandb.jl")
wa = WandbArtifact("some-dataset", type = "dataset")
Wandb.add_file("a.txt")

log(lg, wa)

close(lg)
```

When uploading large artifacts it might be difficult to verify if the files are actually being
uploaded or if the code is just stuck. Run the following in your terminal replacing `$WANDB_DIR`
with the path to the local wandb directory:

```bash
tail -f $WANDB_DIR/latest_run/debug-internal.log
```

If you have another wandb run started after this, you need to modify the path accordingly.
