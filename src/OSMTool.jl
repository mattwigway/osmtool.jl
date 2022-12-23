module OSMTool

using OpenStreetMapPBF, ArchGDAL, RuntimeGeneratedFunctions, Geodesy, CSV, DataFrames
using MacroTools: postwalk

RuntimeGeneratedFunctions.init(@__MODULE__)

include("split-way.jl")
include("speeds.jl")
include("core.jl")
include("filter.jl")

end 