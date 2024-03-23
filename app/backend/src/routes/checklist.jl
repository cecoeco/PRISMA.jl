Oxygen.get("/checklist") do
    try
        json_path::String = PRISMA.checklist_json(
            save_location = Base.joinpath(Base.pwd(), Base.dirname(Base.@__FILE__)),
            filename = "checklist"
        )
        json_content::String = Base.read(json_path, String)
        Base.Filesystem.rm(json_path)
        headers::Vector{Pair{String,String}} = [
            "Content-Type" => "application/json",
            "Content-Disposition" => "attachment; filename=checklist.json"
        ]
        response::HTTP.Response = HTTP.Response(200, headers, json_content)
        return response
    catch error
        error_message::String = "An error occurred while processing the request: $error"
        Base.println(error_message)
        error_headers::Vector{Pair{String,String}} = ["Content-Type" => "text/plain"]
        error_response::HTTP.Response = HTTP.Response(500, error_headers, error_message)
        return error_response
    end
end
