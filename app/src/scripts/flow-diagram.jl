using PRISMA

function send_flow_diagram()
    uploaded_file = request.files["file"]
    if isnothing(uploaded_file)
        return "No file uploaded"
    end
    filename = uploaded_file.filename
    temp_file_path = tempname() * ".csv"
    save(uploaded_file.file, temp_file_path)
    df = PRISMA.flow_diagram_read(temp_file_path)

    parameters = JSON3.read(String(request.body))

    figure = PRISMA.flow_diagram(
        data=df,
        transparent_background=parameters["transparentBackground"],
        grayboxes=parameters["grayBoxes"],
        grayboxes_color=parameters["grayBoxesColor"],
        top_nodes=parameters["topNodes"],
        top_nodes_border=parameters["topNodesBorder"],
        top_nodes_color=parameters["topNodesColor"],
        side_nodes=parameters["sideNodes"],
        side_nodes_border=parameters["sideNodesBorder"],
        side_nodes_color=parameters["sideNodesColor"],
        previous_studies=parameters["previousStudies"],
        other_methods=parameters["otherMethods"],
        node_border_width=parameters["nodeBorderWidth"],
        node_border_color=parameters["nodeBorderColor"],
        font=parameters["textFont"],
        font_color=parameters["textColor"],
        font_size=parameters["textSize"],
        arrow_color=parameters["arrowColor"],
        arrow_head=parameters["arrowHead"],
        arrow_head_size=parameters["arrowHeadSize"],
        arrow_width=parameters["arrowWidth"]
    )
    flow_diagram_svg = PRISMA.flow_diagram_save(
        figure=figure,
        save_format="svg"
    )
    return flow_diagram_svg
end