Oxygen.@post "/flow_diagram" function (req::HTTP.Request)
    uploaded_file = req.body["file"]

    if Base.notnothing(uploaded_file)
        data_frame = PRISMA.flow_diagram_read(file=uploaded_file)
    else
        data_frame = PRISMA.flow_diagram_df()
    end

    figure::Figure = PRISMA.flow_diagram(
        data=data_frame,
        format_numbers=Base.parse(Bool, req.body["format_numbers"]),
        background_color=Base.parse(String, req.body["background_color"]),
        grayboxes=Base.parse(Bool, req.body["grayboxes"]),
        grayboxes_color=Base.parse(String, req.body["grayboxes_color"]),
        top_nodes=Base.parse(Bool, req.body["top_nodes"]),
        top_nodes_border=Base.parse(Bool, req.body["top_nodes_border"]),
        top_nodes_color=Base.parse(String, req.body["top_nodes_color"]),
        side_nodes=Base.parse(Bool, req.body["side_nodes"]),
        side_nodes_border=Base.parse(Bool, req.body["side_nodes_border"]),
        side_nodes_color=Base.parse(String, req.body["side_nodes_color"]),
        previous_studies=Base.parse(Bool, req.body["previous_studies"]),
        other_methods=Base.parse(Bool, req.body["other_methods"]),
        node_border_width=Base.parse(Number, req.body["node_border_width"]),
        node_border_color=Base.parse(String, req.body["node_border_color"]),
        font=Base.parse(String, req.body["font"]),
        font_color=Base.parse(String, req.body["font_color"]),
        font_size=Base.parse(Number, req.body["font_size"]),
        arrow_color=Base.parse(String, req.body["arrow_color"]),
        arrow_head=Base.parse(String, req.body["arrow_head"]),
        arrow_head_size=Base.parse(Number, req.body["arrow_head_size"]),
        arrow_width=Base.parse(Number, req.body["arrow_width"])
    )
    svg_path::String = PRISMA.flow_diagram_save(figure=figure)
    svg_content::String = Base.read(svg_path, String)
    Base.Filesystem.rm(svg_path)
    headers::Vector{Pair{String,String}} = [
        "Content-Type" => "image/svg+xml",
        "Content-Disposition" => "attachment; filename=flow_diagram.svg"
    ]
    response::HTTP.Response = HTTP.Response(200, headers, svg_content)
    return response
end