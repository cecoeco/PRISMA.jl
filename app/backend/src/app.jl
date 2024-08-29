using CSV
using DataFrames
using HTMLTables
using HTTP
using JSON3
using JSONTables
using Oxygen
using PRISMA

const ALLOWED_ORIGINS::Vector{Pair{String,String}} = [
    "Access-Control-Allow-Origin" => "*"
]

const CORS_HEADERS::Vector{Pair{String,String}} = [
    ALLOWED_ORIGINS...,
    "Access-Control-Allow-Methods" => "*",
    "Access-Control-Allow-Headers" => "*"
]

function corshandler(handle::Function)::Function
    return function (request::HTTP.Request)
        if HTTP.method(request) == "OPTIONS"
            return HTTP.Response(200, CORS_HEADERS)
        else
            response::HTTP.Response = handle(request)
            Base.append!(response.headers, ALLOWED_ORIGINS)

            return response
        end
    end
end

Oxygen.get("api/checklist/template") do req::HTTP.Request
    try
        io::IO = IOBuffer()
        CSV.write(io, PRISMA.checklist_df())
        csv::String = String(Base.take!(io))

        return Oxygen.json(
            status=200, 
            Dict{String,String}(
                "checklist_template" => csv
            )
        )
    catch error
        return Oxygen.json(
            status=500, 
            Dict{String,String}(
                "error" => "error generating checklist template: $error"
            )
        )
    end
end

Oxygen.post("api/checklist/generate") do req::HTTP.Request
    try
        paper::PRISMA.Checklist = PRISMA.checklist(req.body)

        clist::DataFrame = paper.df
        clist_title::String = paper.metadata["title"]
        clist_table::String = HTMLTables.table(
            clist, classes="checklist", css=false, editable=true, footer=false
        )

        return Oxygen.json(
            status=200, 
            Dict{String,String}(
                "title" => clist_title, 
                "checklist" => clist_table
            )
        )
    catch error
        return Oxygen.json(
            status=500, 
            Dict{String,String}(
                "error" => "error generating checklist: $error"
            )
        )
    end
end

Oxygen.post("api/checklist/export") do req::HTTP.Request
    try
        checklists::JSON3.Object = Oxygen.json(req)

        csv_files::Dict{String,String} = Dict{String,String}()
        for checklist in checklists["checklists"]
            io::IO = IOBuffer()
            df::DataFrame = HTMLTables.read(checklist["checklist"], DataFrame)
            CSV.write(io, df)
            csv_files["$(checklist["title"]).csv"] = String(Base.take!(io))
            Base.close(io)
        end

        return Oxygen.json(
            status=200, 
            csv_files
        )
    catch error
        return Oxygen.json(
            status=500, 
            Dict{String,String}(
                "error" => "error exporting checklists: $error"
            )
        )
    end
end

function bytes(fd::PRISMA.FlowDiagram, format::AbstractString)::Vector{UInt8}
    tempfile::String = Base.Filesystem.tempname() * "." * format
    flow_diagram_save(tempfile, fd)
    try
        return Base.read(tempfile)
    catch error
        return Base.rethrow(error)
    finally
        Base.Filesystem.rm(tempfile)
    end
end

Oxygen.post("api/flow_diagram/generate") do req::HTTP.Request
    try
        flow_diagram_arguments::JSON3.Object = Oxygen.json(req)

        flow_diagram_dot::PRISMA.FlowDiagram = PRISMA.flow_diagram(
            DataFrame(JSONTables.jsontable(flow_diagram_arguments["data"])),

            background_color =   "$(flow_diagram_arguments["background_color"])",
            grayboxes =          flow_diagram_arguments["grayboxes"],
            grayboxes_color =    "$(flow_diagram_arguments["grayboxes_color"])",
            top_boxes =          flow_diagram_arguments["top_boxes"],
            top_boxes_borders =  flow_diagram_arguments["top_boxes_borders"],
            top_boxes_color =    "$(flow_diagram_arguments["top_boxes_color"])",
            side_boxes =         flow_diagram_arguments["side_boxes"],
            side_boxes_borders = flow_diagram_arguments["side_boxes_borders"],
            side_boxes_color =   "$(flow_diagram_arguments["side_boxes_color"])",
            previous_studies =   flow_diagram_arguments["previous_studies"],
            other_methods =      flow_diagram_arguments["other_methods"],
            borders =            flow_diagram_arguments["borders"],
            border_style =       flow_diagram_arguments["border_style"],
            border_width =       flow_diagram_arguments["border_width"],
            border_color =       "$(flow_diagram_arguments["border_color"])",
            font =               flow_diagram_arguments["font"],
            font_color =         "$(flow_diagram_arguments["font_color"])",
            font_size =          flow_diagram_arguments["font_size"],
            arrow_head =         flow_diagram_arguments["arrow_head"],
            arrow_size =         flow_diagram_arguments["arrow_size"],
            arrow_color =        "$(flow_diagram_arguments["arrow_color"])",
            arrow_width =        flow_diagram_arguments["arrow_width"]
        )

        return Oxygen.json(
            status=200, 
            Dict{String,Vector{UInt8}}(
                "flow_diagram" => bytes(
                    flow_diagram_dot, 
                    "svg"
                )
            )
        )
    catch error
        return Oxygen.json(
            status=500, 
            Dict{String,String}(
                "error" => "error generating flow diagram: $error"
            )
        )
    end
end

Oxygen.post("api/flow_diagram/export") do req::HTTP.Request
    try
        flow_diagram_arguments::JSON3.Object = Oxygen.json(req)

        flow_diagram_dot::PRISMA.FlowDiagram = PRISMA.flow_diagram(
            DataFrame(JSONTables.jsontable(flow_diagram_arguments["data"])),

            background_color =   "$(flow_diagram_arguments["background_color"])",
            grayboxes =          flow_diagram_arguments["grayboxes"],
            grayboxes_color =    "$(flow_diagram_arguments["grayboxes_color"])",
            top_boxes =          flow_diagram_arguments["top_boxes"],
            top_boxes_borders =  flow_diagram_arguments["top_boxes_borders"],
            top_boxes_color =    "$(flow_diagram_arguments["top_boxes_color"])",
            side_boxes =         flow_diagram_arguments["side_boxes"],
            side_boxes_borders = flow_diagram_arguments["side_boxes_borders"],
            side_boxes_color =   "$(flow_diagram_arguments["side_boxes_color"])",
            previous_studies =   flow_diagram_arguments["previous_studies"],
            other_methods =      flow_diagram_arguments["other_methods"],
            borders =            flow_diagram_arguments["borders"],
            border_style =       flow_diagram_arguments["border_style"],
            border_width =       flow_diagram_arguments["border_width"],
            border_color =       "$(flow_diagram_arguments["border_color"])",
            font =               flow_diagram_arguments["font"],
            font_color =         "$(flow_diagram_arguments["font_color"])",
            font_size =          flow_diagram_arguments["font_size"],
            arrow_head =         flow_diagram_arguments["arrow_head"],
            arrow_size =         flow_diagram_arguments["arrow_size"],
            arrow_color =        "$(flow_diagram_arguments["arrow_color"])",
            arrow_width =        flow_diagram_arguments["arrow_width"]
        )

        return Oxygen.json(
            status=200, 
            Dict{String,Vector{UInt8}}(
                "flow_diagram" => bytes(
                    flow_diagram_dot, 
                    flow_diagram_arguments["format"]
                )
            )
        )
    catch error
        return Oxygen.json(
            status=500, 
            Dict{String,String}(
                "error" => "error generating flow diagram: $error"
            )
        )
    end
end

Oxygen.serve(
    host="0.0.0.0",
    port=5050,
    middleware=[corshandler]
)
