module OSMTool

using OpenStreetMapPBF, ArchGDAL, RuntimeGeneratedFunctions
using MacroTools: postwalk

RuntimeGeneratedFunctions.init(@__MODULE__)

include("split-way.jl")
include("core.jl")
include("filter.jl")

end 