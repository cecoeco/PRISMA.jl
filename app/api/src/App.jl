using Oxygen
using HTTP
using PRISMA

include("routes/csv.jl")
include("routes/json.jl")
include("routes/xlsx.jl")
include("routes/flow_diagram.jl")

Oxygen.serve()