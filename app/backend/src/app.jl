using Oxygen
using HTTP
using DataFrames
using PRISMA

const ALLOWED_ORIGINS = ["Access-Control-Allow-Origin" => "*"]

const CORS_HEADERS = [
    ALLOWED_ORIGINS...,
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "GET, POST"
]

function CorsHandler(handle)
    return function (req::HTTP.Request)
        if HTTP.method(req) == "OPTIONS"
            return HTTP.Response(200, CORS_HEADERS)
        else
            r = handle(req)
            append!(r.headers, ALLOWED_ORIGINS)
            return r
        end
    end
end

include("routes/checklist.jl")
include("routes/flow_diagram/csv.jl")
include("routes/flow_diagram/json.jl")
include("routes/flow_diagram/xlsx.jl")
include("routes/flow_diagram/upload.jl")

Oxygen.serve(port=5050, middleware=[CorsHandler])