Oxygen.@get "/json" function (req::HTTP.Request)
    json_path::String = PRISMA.flow_diagram_json(
        save_location=Base.joinpath(
            Base.pwd(),
            Base.dirname(@__FILE__)
        ),
        filename="flow_diagram"
    )
    json_content::String = read(json_path, String)
    headers::Vector{Pair{String,String}} = [
        "Content-Type" => "application/json",
        "Content-Disposition" => "attachment; filename=flow_diagram.json"
    ]
    response::HTTP.Response = HTTP.Response(200, headers, json_content)
    return response
end