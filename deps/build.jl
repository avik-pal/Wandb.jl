using PyCall

try
    pyimport("wandb")
    @info "Using Pre-Installed Wandb Version"
catch e
    try
        run(`$(PyCall.pyprogramname) -m pip install wandb`)
    catch ee
        if !(typeof(ee) <: PyCall.PyError)
            rethrow(ee)
        end
        @warn "Python dependencies not installed.\n" *
              "Either\n" *
              "- Rebuild `PyCall` to use Conda by running the following in Julia REPL " *
              "- `ENV[PYTHON]=\"\"; using Pkg; Pkg.build(\"PyCall\"); Pkg.build(\"Wandb\")\n" *
              "- Or install the dependencies by running `pip` - `pip install wandb>=0.11`"
    end
end