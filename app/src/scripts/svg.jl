using Pkg
Pkg.add("PRISMA")
using PRISMA

function flow_diagram_svg(file_path::String)
    data_frame = PRISMA.flow_diagram_read(file_path)
    figure = PRISMA.flow_diagram(
        data=data_frame,
        transparent_background="transparentBackground",
        grayboxes="grayBoxes",
        grayboxes_color="grayBoxesColor",
        top_nodes="topNodes",
        top_nodes_border="topNodesBorder",
        top_nodes_color="topNodesColor",
        side_nodes="sideNodes",
        side_nodes_border="sideNodesBorder",
        side_nodes_color="sideNodesColor",
        previous_studies="previousStudies",
        other_methods="otherMethods",
        node_border_width="nodeBorderWidth",
        node_border_color="nodeBorderColor",
        font="textFont",
        font_color="textColor",
        font_size="textSize",
        arrow_color="arrowColor",
        arrow_head="arrowHead",
        arrow_head_size="arrowHeadSize",
        arrow_width="arrowWidth"
    )
    flow_diagram_svg = PRISMA.flow_diagram_save(figure=figure,save_format="svg")
    return flow_diagram_svg
end

file_path = ARGS[1]
println(flow_diagram_svg(file_path))