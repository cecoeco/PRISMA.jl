using CSV, DataFrames, HTMLTables, HTTP, JSON3, JSONTables, PRISMA

const ALLOWED_ORIGINS::Vector{Pair{String,String}} = [
    "Access-Control-Allow-Origin" => "*"
]

const CORS_HEADERS::Vector{Pair{String,String}} = [
    ALLOWED_ORIGINS...,
    "Access-Control-Allow-Methods" => "*",
    "Access-Control-Allow-Headers" => "*"
]

function generate_checklists(req::HTTP.Request)::HTTP.Response
    try
        paper::PRISMA.Checklist = PRISMA.checklist(req.body)

        clist_title::String = paper.metadata["title"]
        clist_table::String = HTMLTables.table(paper.df, classes="checklist", css=false, editable=true, footer=false)

        return HTTP.Response(200, JSON3.write(Dict{String,String}("title" => clist_title, "checklist" => clist_table)))
    catch e
        return HTTP.Response(500, "Error generating checklist: $e")
    end
end

function export_checklists(req::HTTP.Request)::HTTP.Response
    try
        checklists::JSON3.Object = JSON3.read(String(req.body))

        csv_files::Dict{String,String} = Dict{String,String}()
        for checklist in checklists["checklists"]
            io::IO = IOBuffer()
            CSV.write(io, HTMLTables.read(checklist["checklist"], DataFrame))
            csv_files["$(checklist["title"]).csv"] = String(take!(io))
        end

        return HTTP.Response(200, JSON3.write(csv_files))
    catch e
        return HTTP.Response(500, "Error exporting checklists: $e")
    end
end

function generate_flow_diagrams(req::HTTP.Request)::HTTP.Response
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

        return HTTP.Response(200, JSON3.write(Dict{String,String}("svg" => svg_string)))
    catch e
        return HTTP.Response(500, "Error generating flow diagram: $e")
    end
end

const ROUTER::HTTP.Router = HTTP.Router()

HTTP.register!(ROUTER, "POST", "/checklist/generate", generate_checklists)
HTTP.register!(ROUTER, "POST", "/checklist/export", export_checklists)
HTTP.register!(ROUTER, "POST", "/flow_diagram", generate_flow_diagrams)

HTTP.serve(ROUTER, "0.0.0.0", 5050)
