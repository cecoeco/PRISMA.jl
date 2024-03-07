Oxygen.@get "/xlsx" function (req::HTTP.Request)
    xlsx_path::String = PRISMA.flow_diagram_xlsx(
        save_location=Base.joinpath(
            Base.pwd(),
            Base.dirname(@__FILE__)
        ),
        filename="flow_diagram"
    )
    xlsx_content::String = read(xlsx_path, String)
    headers::Vector{Pair{String,String}} = [
        "Content-Type" => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        "Content-Disposition" => "attachment; filename=flow_diagram.xlsx"
    ]
    response::HTTP.Response = HTTP.Response(200, headers, xlsx_content)
    return response
end