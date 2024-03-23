Oxygen.get("/flow_diagram/xlsx") do
    try
        xlsx_path::String = PRISMA.flow_diagram_xlsx(
            save_location=Base.joinpath(Base.pwd(), Base.dirname(Base.@__FILE__)),
            filename="flow_diagram",
            sheetname="flow_diagram"
        )
        xlsx_content::Vector{UInt8} = Base.read(xlsx_path)
        Base.Filesystem.rm(xlsx_path)
        headers::Vector{Pair{String,String}} = [
            "Content-Type" => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            "Content-Disposition" => "attachment; filename=flow_diagram.xlsx"
        ]
        response::HTTP.Response = HTTP.Response(200, headers, xlsx_content)
        return response
    catch error
        error_message::String = "An error occurred while processing the request: $error"
        Base.println(error_message)
        error_headers::Vector{Pair{String,String}} = ["Content-Type" => "text/plain"]
        error_response::HTTP.Response = HTTP.Response(500, error_headers, error_message)
        return error_response
    end
end