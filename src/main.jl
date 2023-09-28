login(; kwargs...) = wandb.login(; kwargs...)

mutable struct WandbLogger <: AbstractLogger
  wrun::Py
  step_increment::Int
  global_step::Int
  min_level::LogLevel
end

PythonCall.ispy(::WandbLogger) = true

PythonCall.Py(wa::WandbLogger) = wa.wrun

"""
    WandbLogger(; project, name=nothing, min_level=Info, step_increment=1,
                start_step=0, kwargs...)

Create a WandbLogger that logs to the wandb project `project`. See the documentation for
`wandb.init` for more details (also accessible in the Julia REPL using
`? Wandb.wandb.init`).
"""
function WandbLogger(; project, name=nothing, min_level=Info, step_increment=1,
  start_step=0, config=Dict(), kwargs...)
  wrun = nothing
  config = _to_dict(config)
  @static if Sys.iswindows()
    if :settings in keys(kwargs)
      wrun = wandb.init(; project, name, config, kwargs...)
    else
      wrun = wandb.init(; project, name, config,
        settings=wandb.Settings(; start_method="thread"), kwargs...)
    end
  else
    wrun = wandb.init(; project, name, config, kwargs...)
  end
  if !isnothing(name) && wrun.name != name
    @warn "There is an ongoing wandb run. Please `close` the run before initializing a \
           new one."
  end
  return WandbLogger(wrun, step_increment, start_step, min_level)
end

function Base.show(io::IO, lg::WandbLogger)
  Base.println(io, "WandbLogger:")
  Base.println(io, "  Project: $(lg.wrun.project)")
  Base.println(io, "  Name: $(lg.wrun.name)")
  Base.println(io, "  Id: $(lg.wrun.id)")
  Base.println(io, "  Min Level: $(lg.min_level)")
  Base.print(io, "  Url: ")
  Base.printstyled(io, "$(lg.wrun.url)"; color=:yellow)
  return
end

"""
    increment_step!(lg::WandbLogger, Δstep)

Increment the global step by `Δstep` and return the new global step.
"""
function increment_step!(lg::WandbLogger, Δstep)
  lg.global_step += Δstep
  return lg.global_step
end

"""
    log(lg::WandbLogger, logs::Dict; kwargs...)

For more details checkout `wandb.log` (or `? Wandb.wandb.log` in the Julia REPL).
"""
log(lg::WandbLogger, logs::Dict; kwargs...) = lg.wrun.log(_to_dict(logs); kwargs...)

"""
    update_config!(lg::WandbLogger, dict::Dict; kwargs...)

For more details checkout `wandb.config` (or `? Wandb.wandb.config` in the Julia REPL).
"""
function update_config!(lg::WandbLogger, dict::Dict; kwargs...)
  return lg.wrun.config.update(pydict(dict); kwargs...)
end

"""
    close(lg::WandbLogger; kwargs...)

Terminate the current run. For more details checkout `wandb.finish` (or
`? Wandb.wandb.finish` in the Julia REPL).
"""
Base.close(lg::WandbLogger; kwargs...) = lg.wrun.finish(; kwargs...)

"""
    save(lg::WandbLogger, args...; kwargs...)

Ensure all files matching `glob_str` are synced to wandb with the policy specified. For
more details checkout `wandb.save` (or `? Wandb.wandb.save` in the Julia REPL).
"""
save(lg::WandbLogger, args...; kwargs...) = lg.wrun.save(args...; kwargs...)

"""
    get_config(lg::WandbLogger)

Return the current config dict.
"""
get_config(lg::WandbLogger) = lg.wrun.config

"""
    get_config(lg::WandbLogger, key::String)

Get the value of `key` from the config.
"""
get_config(lg::WandbLogger, key::String) = pyconvert(Any, lg.wrun.config[key])

# Logging Types: Image, Video, Histogram, 3D Objects, PR Curve
## We assume the images to be ordered as per (F)Lux conventions
"""
    Image(img::AbstractArray{T, 3}; kwargs...)
    Image(img::AbstractMatrix; kwargs...)
    Image(img::Union{String, IO}; kwargs...)

Creates a `wandb.Image` object that can be logged using `Wandb.log`. For more details
checkout `wandb.Image` (or `? Wandb.wandb.Image` in the Julia REPL).
"""
function Image(img::AbstractArray{T, 3}; kwargs...) where {T}
  return wandb.Image(_to_numpy(permutedims(img, (3, 1, 2))); kwargs...)
end

Image(img::AbstractMatrix; kwargs...) = wandb.Image(_to_numpy(img'); kwargs...)

Image(img::String; kwargs...) = wandb.Image(img; kwargs...)

Image(img::IO; kwargs...) = wandb.Image(pytextio(img); kwargs...)

function Image(img::Any; kwargs...)
  mime_pairs = ((MIME"image/png"(), "png"), (MIME"image/jpeg"(), "jpg"))
  for (mime, ext) in mime_pairs
    showable(mime, img) || continue
    path = joinpath(mktempdir(), "img.$ext") # cleaned up on Julia process exit
    open(path; write=true) do io
      return show(io, mime, img)
    end
    return wandb.Image(path; kwargs...)
  end
  error("Fallback image conversion failed: could not `show` image of type `$(typeof(img))`
         as any of $(first.(mime_pairs))")
  return
end

"""
    Video(vid::AbstractArray{T, 5}; kwargs...)
    Video(vid::AbstractArray{T, 4}; kwargs...)
    Video(vid::Union{String, IO}; kwargs...)

Creates a `wandb.Video` object that can be logged using `Wandb.log`. For more details
checkout `wandb.Video` (or `? Wandb.wandb.Video` in the Julia REPL).
"""
function Video(vid::AbstractArray{T, 5}; kwargs...) where {T}
  return wandb.Video(_to_numpy(permutedims(vid, (5, 4, 3, 2, 1))); kwargs...)
end

function Video(vid::AbstractArray{T, 4}; kwargs...) where {T}
  return wandb.Video(_to_numpy(permutedims(vid, (4, 3, 2, 1))); kwargs...)
end

Video(vid::String; kwargs...) = wandb.Video(vid; kwargs...)

Video(vid::IO; kwargs...) = wandb.Video(pytextio(vid); kwargs...)

"""
    Wandb.Histogram(args...; kwargs...)

Creates a `wandb.Histogram` object that can be logged using `Wandb.log`. For more details
checkout `wandb.Histogram` (or `? Wandb.wandb.Histogram` in the Julia REPL).
"""
Histogram(args...; kwargs...) = wandb.Histogram(args...; kwargs...)

"""
    Object3D(path_or_io::Union{String, IO})
    Object3D(data::AbstractMatrix)

Creates a `wandb.Object3D` object that can be logged using `Wandb.log`. For more details
checkout `wandb.Object3D` (or `? Wandb.wandb.Object3D` in the Julia REPL).
"""
Object3D(path::String) = wandb.Object3D(path)

Object3D(io::IO) = wandb.Object3D(pytextio(io))

Object3D(data::AbstractMatrix) = wandb.Object3D(_to_numpy(data))

"""
    Table(; data::AbstractMatrix, columns::AbstractVector)

Creates a `wandb.Table` object that can be logged using `Wandb.log`. For more details
checkout `wandb.Table` (or `? Wandb.wandb.Table` in the Julia REPL).

!!! note

    Currently we don't support passing DataFrame to the Table. (PRs implementing this
    are welcome)
"""
function Table(; data::AbstractMatrix, columns::AbstractVector)
  return wandb.Table(; data=_to_list(data), columns=_to_list(columns))
end

# Plotting
"""
    plot_line(table::wandb.Table, x::String, y::String, stroke::String, title::String)

Construct a line plot.

## Arguments:

  - table (wandb.Table): Table of data.
  - x (string): Name of column to as for x-axis values.
  - y (string): Name of column to as for y-axis values.
  - stroke (string): Name of column to map to the line stroke scale.
  - title (string): Plot title.

## Returns:

A plot object, to be passed to Wandb.log()
"""
function plot_line(table::Py, x::String, y::String, stroke::String, title::String)
  return wandb.plot.line(table, x, y, stroke, title)
end

"""
    plot_scatter(table::Py, x::String, y::String, title::String)

Construct a scatter plot.

## Arguments:

  - table (wandb.Table): Table of data.
  - x (string): Name of column to as for x-axis values.
  - y (string): Name of column to as for y-axis values.
  - title (string): Plot title.

## Returns:

A plot object, to be passed to Wandb.log()
"""
function plot_scatter(table::Py, x::String, y::String, title::String)
  return wandb.plot.scatter(table, x, y, title)
end

"""
    plot_bar(table::Py, label::String, value::String, title::String)

Construct a bar plot.

## Arguments:

  - table (wandb.Table): Table of data.
  - label (string): Name of column to use as each bar's label.
  - value (string): Name of column to use as each bar's value.
  - title (string): Plot title.

## Returns:

A plot object, to be passed to Wandb.log()
"""
function plot_bar(table::Py, label::String, value::String, title::String)
  return wandb.plot.bar(table, label, value, title)
end

"""
    plot_histogram(table::Py, value::String, title::String)

Construct a histogram plot.

## Arguments:

  - table (wandb.Table): Table of data.
  - value (string): Name of column to use as data for bucketing.
  - title (string): Plot title.

## Returns:

A plot object, to be passed to Wandb.log()
"""
function plot_histogram(table::Py, value::String, title::String)
  return wandb.plot.histogram(table, value, title)
end

"""
    plot_line_series(xs::AbstractVecOrMat, ys::AbstractMatrix, keys::AbstractVector,
                     title::String, xname::String)

Construct a line series plot.

## Arguments:

  - xs (AbstractMatrix or AbstractVector): Array of arrays of x values
  - ys (AbstractMatrix): Array of y values
  - keys (AbstractVector): Array of labels for the line plots
  - title (string): Plot title.
  - xname (string): Title of x-axis

## Returns:

A plot object, to be passed to Wandb.log()
"""
function plot_line_series(xs::AbstractVecOrMat, ys::AbstractMatrix, keys::AbstractVector,
  title::String, xname::String)
  return wandb.plot.line_series(_to_list(xs), _to_list(ys), _to_list(keys), title, xname)
end

# TODO: Wrap the rest of the plotting functions: pr_curve, confusion_matrix, roc_curve, etc.

"""
    version()

Return the Wandb python client version number (i.e., `Wandb.wandb.__version__`).
"""
function version()
  return VersionNumber(map(Base.Fix1(parse, UInt32),
    split(string(wandb.__version__), "."))...)
end

"""
    update_client()

Updates the python dependencies in `Wandb.jl`.
"""
function update_client()
  msg = pyconvert(Any, Wandb.wandb.sdk.internal.update.check_available(wandb.__version__))
  if msg !== nothing
    @info "Trying to update Wandb to the latest stable release."
    CondaPkg.update()
    @info "Please restart Julia session to use the updated release."
  else
    @info "No new version of Wandb Client found."
  end
end
