Oxygen.@post "/flow_diagram" function (req::HTTP.Request)
    uploaded_file = req.body["file"]

    if notnothing(uploaded_file)
        data_frame = PRISMA.flow_diagram_read(uploaded_file)
    else
        data_frame = PRISMA.flow_diagram_df()
    end

    figure_path = PRISMA.flow_diagram(
        data=data_frame,
        format_numbers=req.body["format_numbers"],
        background_color=req.body["background_color"],
        grayboxes=req.body["grayboxes"],
        grayboxes_color=req.body["grayboxes_color"],
        top_nodes=req.body["top_nodes"],
        top_nodes_border=req.body["top_nodes_border"],
        top_nodes_color=req.body["top_nodes_color"],
        side_nodes=req.body["side_nodes"],
        side_nodes_border=req.body["side_nodes_border"],
        side_nodes_color=req.body["side_nodes_color"],
        previous_studies=req.body["previous_studies"],
        other_methods=req.body["other_methods"],
        node_border_width=req.body["node_border_width"],
        node_border_color=req.body["node_border_color"],
        font=req.body["font"],
        font_color=req.body["font_color"],
        font_size=req.body["font_size"],
        arrow_color=req.body["arrow_color"],
        arrow_head=req.body["arrow_head"],
        arrow_head_size=req.body["arrow_head_size"],
        arrow_width=req.body["arrow_width"]
    )
    svg_path = PRISMA.flow_diagram_save(figure_path)
    return svg_path
end