using Pkg
Pkg.add("PRISMA")
using PRISMA

function flow_diagram_svg(
    file_path::String,
    format_numbers::Bool,
    background_color::String,
    grayboxes::Bool,
    grayboxes_color::String,
    top_nodes::Bool,
    top_nodes_border::Bool,
    top_nodes_color::String,
    side_nodes::Bool,
    side_nodes_border::Int,
    side_nodes_color::String,
    previous_studies::Bool,
    other_methods::Bool,
    node_border_width::Int,
    node_border_color::String,
    font::Int,
    font_color::String,
    font_size::Int,
    arrow_color::String,
    arrow_head::String,
    arrow_head_size::Int,
    arrow_width::Int
)
    data_frame = PRISMA.flow_diagram_read(file_path)
    figure = PRISMA.flow_diagram(
        data=data_frame,
        format_numbers=format_numbers,
        transparent_background=background_color,
        grayboxes=grayboxes,
        grayboxes_color=grayboxes_color,
        top_nodes=top_nodes,
        top_nodes_border=top_nodes_border,
        top_nodes_color=top_nodes_color,
        side_nodes=side_nodes,
        side_nodes_border=side_nodes_border,
        side_nodes_color=side_nodes_color,
        previous_studies=previous_studies,
        other_methods=other_methods,
        node_border_width=node_border_width,
        node_border_color=node_border_color,
        font=font,
        font_color=font_color,
        font_size=font_size,
        arrow_color=arrow_color,
        arrow_head=arrow_head,
        arrow_head_size=arrow_head_size,
        arrow_width=arrow_width
    )
    flow_diagram_svg = PRISMA.flow_diagram_save(figure=figure, save_format="svg")
    return flow_diagram_svg
end

file_path = ARGS[1]

println(
    flow_diagram_svg(
        file_path,
        parse(Bool, ARGS[2]),
        ARGS[3],
        parse(Bool, ARGS[4]),
        ARGS[5],
        parse(Bool, ARGS[6]),
        parse(Bool, ARGS[7]),
        ARGS[8],
        parse(Bool, ARGS[9]),
        parse(Int, ARGS[10]),
        ARGS[11],
        parse(Bool, ARGS[12]),
        parse(Bool, ARGS[13]),
        parse(Int, ARGS[14]),
        ARGS[15],
        parse(Int, ARGS[16]),
        ARGS[17],
        parse(Int, ARGS[18]),
        ARGS[19],
        ARGS[20],
        parse(Int, ARGS[21]),
        parse(Int, ARGS[22])
    )
)
