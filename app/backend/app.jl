using CSV, DataFrames, HTMLTables, HTTP, JSON3, JSONTables, Oxygen, PRISMA

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

Oxygen.post("/checklist/generate") do req::HTTP.Request
    try
        paper::PRISMA.Checklist = PRISMA.checklist(req.body)

        clist_title::String = paper.metadata["title"]
        clist_table::String = HTMLTables.table(paper.df, classes="checklist", css=false, editable=true, footer=false)

        return Oxygen.json(
            status=200, 
            Dict{String,String}("title" => clist_title, "checklist" => clist_table)
        )
    catch error
        return Oxygen.json(
            status=500, 
            Dict{String,String}("error" => "error generating checklist: $error")
        )
    end
end

Oxygen.post("/checklist/export") do req::HTTP.Request
    try
        checklists::JSON3.Object = JSON3.read(String(req.body))

        csv_files::Dict{String,String} = Dict{String,String}()
        for checklist in checklists["checklists"]
            io::IO = IOBuffer()
            CSV.write(io, HTMLTables.read(checklist["checklist"], DataFrame))
            csv_files["$(checklist["title"]).csv"] = String(take!(io))
        end

        return Oxygen.json(status=200, csv_files)
    catch error
        return Oxygen.json(status=500, Dict{String,String}("error" => "error exporting checklists: $error"))
    end
end

Oxygen.post("/flow_diagram/generate") do req::HTTP.Request
    try
        flow_diagram_options::JSON3.Object = JSON3.read(String(req.body))

        flow_diagram_gv::PRISMA.FlowDiagram = PRISMA.flow_diagram(
            DataFrame(JSONTables.jsontable(flow_diagram_options["data"])),

            background_color =   flow_diagram_options["background_color"],
            grayboxes =          flow_diagram_options["grayboxes"],
            grayboxes_color =    flow_diagram_options["grayboxes_color"],
            top_boxes =          flow_diagram_options["top_boxes"],
            top_boxes_borders =  flow_diagram_options["top_boxes_borders"],
            top_boxes_color =    flow_diagram_options["top_boxes_color"],
            side_boxes =         flow_diagram_options["side_boxes"],
            side_boxes_borders = flow_diagram_options["side_boxes_borders"],
            side_boxes_color =   flow_diagram_options["side_boxes_color"],
            previous_studies =   flow_diagram_options["previous_studies"],
            other_methods =      flow_diagram_options["other_methods"],
            borders =            flow_diagram_options["borders"],
            border_style =       flow_diagram_options["border_style"],
            border_width =       flow_diagram_options["border_width"],
            border_color =       flow_diagram_options["border_color"],
            font =               flow_diagram_options["font"],
            font_color =         flow_diagram_options["font_color"],
            font_size =          flow_diagram_options["font_size"],
            arrow_head =         flow_diagram_options["arrow_head"],
            arrow_size =         flow_diagram_options["arrow_size"],
            arrow_color =        flow_diagram_options["arrow_color"],
            arrow_width =        flow_diagram_options["arrow_width"]
        )

        tempname_svg::String = Base.Filesystem.tempname() * ".svg"
        PRISMA.flow_diagram_save(tempname_svg, flow_diagram_gv)
        svg_string::String = Base.read(tempname_svg, String)
        Base.Filesystem.rm(tempname_svg)

        return Oxygen.json(status=200, Dict{String,String}("svg" => svg_string))
    catch error
        return Oxygen.json(status=500, Dict{String,String}("error" => "error generating flow diagram: $error"))
    end
end

Oxygen.serve(host="0.0.0.0", port=5050, middleware=[corshandler])
