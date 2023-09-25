"""
    WandbArtifact(args...; kwargs...)

WandbArtifact is a wrapper around `wandb.Artifact`. See the documentation for
`wandb.Artifact` for the different functionalities. Most of the functions can be called
using `Wandb.<function name>(::WandbArticact, args...; kwargs...)`.
"""
struct WandbArtifact
  artifact::Py
end

PythonCall.ispy(::WandbArtifact) = true

PythonCall.Py(wa::WandbArtifact) = wa.artifact

WandbArtifact(args...; kwargs...) = WandbArtifact(wandb.Artifact(args...; kwargs...))

Base.show(io::IO, ::WandbArtifact) = Base.print(io, "WandbArtifact()")

for func in (:download, :get, :finalize, :wait)
  @eval begin
    function Base.$(func)(wa::WandbArtifact, args...; kwargs...)
      return wa.artifact.$(func)(args...; kwargs...)
    end
  end
end

for func in (:add, :add_file, :add_dir, :add_reference, :checkout, :delete,
  :get_added_local_path_name, :get_path, :logged_by, :new_file, :used_by,
  :verify, :save)
  @eval begin
    function $(func)(wa::WandbArtifact, args...; kwargs...)
      return wa.artifact.$(func)(args...; kwargs...)
    end
  end
end

log(::WandbLogger, wa::WandbArtifact) = wandb.log_artifact(wa.artifact)
