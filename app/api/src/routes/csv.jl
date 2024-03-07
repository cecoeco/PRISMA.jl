Oxygen.@get "/csv" function (req::HTTP.Request)
    csv_path::String = PRISMA.flow_diagram_csv(
        save_location=Base.joinpath(
            Base.pwd(),
            Base.dirname(@__FILE__)
        ),
        filename="flow_diagram"
    )
    csv_content::String = Base.read(csv_path, String)
    headers::Vector{Pair{String,String}} = [
        "Content-Type" => "text/csv",
        "Content-Disposition" => "attachment; filename=flow_diagram.csv"
    ]
    response::HTTP.Response = HTTP.Response(200, headers, csv_content)
    return response
end