module OSMTool

using OpenStreetMapPBF, ArchGDAL, RuntimeGeneratedFunctions
using MacroTools: postwalk

RuntimeGeneratedFunctions.init(@__MODULE__)

include("core.jl")
include("filter.jl")

end 