using Pkg; Pkg.add(url="https://github.com/cecoeco/PRISMA.jl", rev="master")

using PRISMA

function flow_diagram_svg(
    file_path::String=ARGS[1],
    format_numbers::Bool=parse(Bool, ARGS[2]),
    background_color::String=ARGS[3],
    grayboxes::Bool=parse(Bool, ARGS[4]),
    grayboxes_color::String=ARGS[5],
    top_nodes::Bool=parse(Bool, ARGS[6]),
    top_nodes_border::Bool=parse(Bool, ARGS[7]),
    top_nodes_color::String=ARGS[8],
    side_nodes::Bool=parse(Bool, ARGS[9]),
    side_nodes_border::Int=parse(Int, ARGS[10]),
    side_nodes_color::String=ARGS[11],
    previous_studies::Bool=parse(Bool, ARGS[12]),
    other_methods::Bool=parse(Bool, ARGS[13]),
    node_border_width::Int=parse(Int, ARGS[14]),
    node_border_color::String=ARGS[15],
    font::Int=parse(Int, ARGS[16]),
    font_color::String=ARGS[17],
    font_size::Int=parse(Int, ARGS[18]),
    arrow_color::String=ARGS[19],
    arrow_head::String=ARGS[20],
    arrow_head_size::Int=parse(Int, ARGS[21]),
    arrow_width::Int=parse(Int, ARGS[22])
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
    flow_diagram_path = PRISMA.flow_diagram_save(figure=figure)
    return flow_diagram_path
end

svg = flow_diagram_svg()
println(svg)