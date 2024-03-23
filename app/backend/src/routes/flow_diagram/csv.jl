Oxygen.get("/flow_diagram/csv") do
    try
        csv_path::String = PRISMA.flow_diagram_csv(
            save_location=Base.joinpath(Base.pwd(), Base.dirname(Base.@__FILE__)),
            filename="flow_diagram"
        )
        csv_content::String = Base.read(csv_path, String)
        Base.Filesystem.rm(csv_path)
        headers::Vector{Pair{String,String}} = [
            "Content-Type" => "text/csv",
            "Content-Disposition" => "attachment; filename=flow_diagram.csv"
        ]
        response::HTTP.Response = HTTP.Response(200, headers, csv_content)
        return response
    catch error
        error_message::String = "An error occurred while processing the request: $error"
        Base.println(error_message)
        error_headers::Vector{Pair{String,String}} = ["Content-Type" => "text/plain"]
        error_response::HTTP.Response = HTTP.Response(500, error_headers, error_message)
        return error_response
    end
end