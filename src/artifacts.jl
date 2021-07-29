# Wandb Artifacts
mutable struct WandbArtifact
    artifact::PyObject
end

WandbArtifact(args...; kwargs...) =
    WandbArtifact(wandb.Artifact(args...; kwargs...))

Base.show(io::IO, ::WandbArtifact) = Base.print(io, "WandbArtifact()")

for func in (:download, :get, :finalize, :wait)
    @eval begin
        Base.$(func)(wa::WandbArtifact, args...; kwargs...) =
            wa.artifact.$(func)(args...; kwargs...)
    end
end

for func in (:add, :add_file, :add_dir, :add_reference, :checkout, :delete,
             :get_added_local_path_name, :get_path, :logged_by, :new_file,
             :used_by, :verify, :save)
    @eval begin
        $(func)(wa::WandbArtifact, args...; kwargs...) =
            wa.artifact.$(func)(args...; kwargs...)
    end
end


Base.log(::WandbLogger, wa::WandbArtifact) = wandb.log_artifact(wa.artifact)
