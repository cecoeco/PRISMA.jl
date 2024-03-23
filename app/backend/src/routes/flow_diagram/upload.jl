Oxygen.post("/flow_diagram/upload") do req::HTTP.Request
    spreadsheet::String = req.body["file"]
    dataframe::DataFrame = PRISMA.flow_diagram_read(file=spreadsheet)
    headers::Vector{Pair{String,String}} = [
    ]
    response::HTTP.Response = HTTP.Response(200, headers, dataframe)
    return response
end