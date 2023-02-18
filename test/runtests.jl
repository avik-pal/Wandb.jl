using Test, Wandb, PlotlyJS

@testset "Wandb.Image" begin
  # Take a generic object that supports `show(io, MIME"image/png", img)`
  # and try to pass it to `Wandb.Image`.
  p1 = Plot(scatter(; x=1:10, y=2:11))
  img = Wandb.Image(p1)
  @test img.format == "png"

  # Test error path
  @test_throws ErrorException Wandb.Image(["hi"])
end
