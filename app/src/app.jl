using CSV
using DataFrames
using HTMLTables
using HTTP
using JSONTables
using JSON3
using NodeJS
using Oxygen
using PRISMA

const FRONTEND_BUILD::String = joinpath(dirname(@__DIR__), "dist")

function build_frontend()::Nothing
    @info "Building frontend..."

    if isdir(FRONTEND_BUILD)
        @info "Removing existing build directory..."
        rm(FRONTEND_BUILD, force=true, recursive=true)
    end

    if dirname(pwd()) != "app"
        @info "Switching to app directory..."
        cd("app")
    end

    run(`$(NodeJS.npm_cmd()) install`)
    run(`$(NodeJS.npm_cmd()) run build`)

    @info "Finished building frontend"

    return nothing
end

function runapp(; kwargs...)::Nothing
    build_frontend()
    Oxygen.serve(; kwargs...)

    return nothing
end

Oxygen.get("*") do 
    try
        return Oxygen.html(
            status=200,
            Base.read(joinpath(FRONTEND_BUILD, "index.html"), String)
        )
    catch error
        return Oxygen.json(
            status=500,
            Dict{String,String}(
                "error" => "error loading frontend: $error"
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
            csv_files["$(checklist["title"]).csv"] = String(take!(io))
            close(io)
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

runapp(host="0.0.0.0", port=5050, async=true)