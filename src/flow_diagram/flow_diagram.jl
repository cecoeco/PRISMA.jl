"""
    flow_diagram(;
        data::DataFrame=flow_diagram_df(),
        format_numbers::Bool=true,
        backend::String="CairoMakie",
        background_color="#fff",
        grayboxes::Bool=true,
        grayboxes_color="#f0f0f0",
        top_nodes::Bool=true,
        top_nodes_border=false,
        top_nodes_color="#ffc000",
        side_nodes::Bool=true,
        side_nodes_border=false,
        side_nodes_color="#95cbff",
        previous_studies::Bool=true,
        other_methods::Bool=true,
        node_border_width::Number=1,
        node_border_color="#000",
        font::String="Arial",
        font_color="black",
        font_size::Number=10,
        arrow_color="black",
        arrow_head=:utriangle,
        arrow_head_size::Number=12,
        arrow_width::Number=1
    )

Generates a flow diagram.

# Arguments
- `data::DataFrame`: The flow diagram dataframe.
- `format_numbers::Bool`: Whether to format numbers in the dataframe.
- `backend::String`: The backend to use for the flow diagram.
- `background_color::String`: The background color of the flow diagram.
- `grayboxes::Bool`: Whether to show gray boxes in the flow diagram.
- `grayboxes_color::String`: The color of the gray boxes in the flow diagram.
- `top_nodes::Bool`: Whether to show the top nodes in the flow diagram.
- `top_nodes_border::Bool`: Whether to show the top nodes border in the flow diagram.
- `top_nodes_color::String`: The color of the top nodes in the flow diagram.
- `side_nodes::Bool`: Whether to show the side nodes in the flow diagram.
- `side_nodes_border::Bool`: Whether to show the side nodes border in the flow diagram.
- `side_nodes_color::String`: The color of the side nodes in the flow diagram.
- `previous_studies::Bool`: Whether to show the previous studies in the flow diagram.
- `other_methods::Bool`: Whether to show the other methods in the flow diagram.
- `node_border_width::Number`: The width of the border of the nodes in the flow diagram.
- `node_border_color::String`: The color of the border of the nodes in the flow diagram.
- `font::String`: The font to use for the flow diagram.
- `font_color::String`: The color of the font in the flow diagram.
- `font_size::Number`: The size of the font in the flow diagram.
- `arrow_color::String`: The color of the arrows in the flow diagram.
- `arrow_head::Symbol`: The arrow head to use for the arrows in the flow diagram.
- `arrow_head_size::Number`: The size of the arrow head in the flow diagram.
- `arrow_width::Number`: The width of the arrow in the flow diagram.

# Returns
- `Makie.Figure`: The flow diagram figure.
"""
function flow_diagram(;
    data::DataFrame=flow_diagram_df(),
    format_numbers::Bool=true,
    backend::String="CairoMakie",
    background_color="#fff",
    grayboxes::Bool=true,
    grayboxes_color="#f0f0f0",
    top_nodes::Bool=true,
    top_nodes_border=false,
    top_nodes_color="#ffc000",
    side_nodes::Bool=true,
    side_nodes_border=false,
    side_nodes_color="#95cbff",
    previous_studies::Bool=true,
    other_methods::Bool=true,
    node_border_width::Number=1,
    node_border_color="#000",
    font::String="Arial",
    font_color="black",
    font_size::Number=10,
    arrow_color="black",
    arrow_head=:utriangle,
    arrow_head_size::Number=12,
    arrow_width::Number=1
)
    backend = lowercase(backend)
    if backend == "cairomakie" || backend == "cairo"
        CairoMakie.activate!()
    elseif backend == "glmakie" || backend == "gl"
        GLMakie.activate!()
    elseif backend == "wglmakie" || backend == "wgl"
        WGLMakie.activate!()
    elseif backend == "rprmakie" || backend == "rpr"
        RPRMakie.activate!()
    else
        println("Backend not supported. Please choose from \"CairoMakie\", \"GLMakie\", \"WGLMakie\", or \"RPRMakie\".")
    end

    if format_numbers
        data = format_df(data)
    end
    
    canvas_height::Number = 850
    canvas_width::Number = 1100
    figure::Figure = Figure(backgroundcolor=background_color, size=(canvas_width, canvas_height))
    axis::Axis = Axis(figure[1, 1], backgroundcolor=background_color, width=canvas_width, height=canvas_height)
    hidedecorations!(axis)
    hidespines!(axis)
    xlims!(axis, 0, canvas_width)
    ylims!(axis, 0, canvas_height)

    column_1::Number = 25
    column_2::Number = column_1 + 40
    column_3::Number = column_2 + 200
    column_4::Number = column_3 + 200
    column_5::Number = column_4 + 200
    column_6::Number = column_5 + 200

    column_1_width::Number = 25
    column_2_width::Number = 175
    column_3_width::Number = 175
    column_4_width::Number = 175
    column_5_width::Number = 175
    column_6_width::Number = 175
    
    column_2_gap::Number = column_3 - column_2 - column_2_width
    column_3_gap::Number = column_4 - column_3 - column_3_width
    column_4_gap::Number = column_5 - column_4 - column_4_width
    column_5_gap::Number = column_6 - column_5 - column_5_width

    row_1::Number = canvas_height - 50
    row_2::Number = row_1 - 165
    row_3::Number = row_2 - 70
    row_4::Number = row_3 - 70
    row_5::Number = row_4 - 120
    row_6::Number = row_5 - 95
    row_7::Number = row_6 - 95

    row_1_height::Number = 25
    row_2_height::Number = 150
    row_3_height::Number = 50
    row_4_height::Number = 50
    row_5_height::Number = 100
    row_6_height::Number = 75
    row_7_height::Number = 75

    row_2_gap::Number = row_2 - row_3 - row_3_height
    row_3_gap::Number = row_3 - row_4 - row_4_height
    row_4_gap::Number = row_4 - row_5 - row_5_height
    row_5_gap::Number = row_5 - row_6 - row_6_height
    row_6_gap::Number = row_6 - row_7 - row_7_height

    node_padding::Number = percentage("5%")

    # bottom left -> bottom right -> top right -> top left

    node_dictionary::Dict{String, Dict} = Dict(
        "node_1" => Dict(
            "node_polygons" => Point2f[(column_2, row_1), (column_2 + column_2_width, row_1), (column_2 + column_2_width, row_1 + row_1_height), (column_2, row_1 + row_1_height)],
            "node_colors" => if grayboxes == true grayboxes_color else top_nodes_color end,
            "node_border_widths" => if top_nodes_border == true || grayboxes != true node_border_width else 0 end,
            "node_visibility" => if top_nodes == true || previous_studies == true true else false end,
            "node_texts" => "$(data[01, :node_text])",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_2 + column_2_width * 0.5, row_1 + row_1_height * 0.5)],
            "node_text_widths" => column_2_width * (1 - node_padding * 2)
        ),
        "node_2" => Dict(
            "node_polygons" => Point2f[(column_3, row_1), (column_4 + column_4_width, row_1), (column_4 + column_4_width, row_1 + row_1_height), (column_3, row_1 + row_1_height)],
            "node_colors" => top_nodes_color,
            "node_border_widths" => if top_nodes_border == true node_border_width else 0 end,
            "node_visibility" => top_nodes,
            "node_texts" => "$(data[02, :node_text])",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(((column_3 + column_3_width * 0.5) + (column_4 + column_4_width * 0.5)) * 0.5, row_1 + row_1_height * 0.5)],
            "node_text_widths" => column_4_width + column_4_gap + column_5_width * (1 - node_padding * 2)
        ),
        "node_3" => Dict(
            "node_polygons" => Point2f[(column_5, row_1), (column_6 + column_6_width, row_1), (column_6 + column_6_width, row_1 + row_1_height), (column_5, row_1 + row_1_height)],
            "node_colors" => if grayboxes == true grayboxes_color else top_nodes_color end,
            "node_border_widths" => if top_nodes_border == true || grayboxes != true node_border_width else 0 end,
            "node_visibility" => if top_nodes == true || other_methods == true true else false end,
            "node_texts" => "$(data[03, :node_text])",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(((column_5 + column_5_width * 0.5) + (column_6 + column_6_width * 0.5)) * 0.5, row_1 + row_1_height * 0.5)],
            "node_text_widths" => column_5_width + column_5_gap + column_6_width * (1 - node_padding * 2)
        ),
        "node_4" => Dict(
            "node_polygons" => Point2f[(column_1, row_2), (column_1 + column_1_width, row_2), (column_1 + column_1_width, row_2 + row_2_height), (column_1, row_2 + row_2_height)],
            "node_colors" => side_nodes_color,
            "node_border_widths" => if side_nodes_border == true node_border_width else 0 end,
            "node_visibility" => side_nodes,
            "node_texts" => "$(data[04, :node_text])",
            "node_text_rotations" => pi * 0.5,
            "node_text_positions" => Point2f[(column_1 + column_1_width * 0.5, row_2 + row_2_height * 0.5)],
            "node_text_widths" => column_1_width * (1 - node_padding * 2)
        ),
        "node_5" => Dict(
            "node_polygons" => Point2f[(column_1, row_5), (column_1 + column_1_width, row_5), (column_1 + column_1_width, row_3 + row_3_height), (column_1, row_3 + row_3_height)],
            "node_colors" => side_nodes_color,
            "node_border_widths" => if side_nodes_border == true node_border_width else 0 end,
            "node_visibility" => side_nodes,
            "node_texts" => "$(data[05, :node_text])",
            "node_text_rotations" => pi * 0.5,
            "node_text_positions" => Point2f[(column_1 + column_1_width * 0.5, (row_3 + row_3_height + row_5)/2)],
            "node_text_widths" => column_1_width * (1 - node_padding * 2)
        ),
        "node_6" => Dict(
            "node_polygons" => Point2f[(column_1, row_7), (column_1 + column_1_width, row_7), (column_1 + column_1_width, row_6 + row_6_height), (column_1, row_6 + row_6_height)],
            "node_colors" => side_nodes_color,
            "node_border_widths" => if side_nodes_border == true node_border_width else 0 end,
            "node_visibility" => side_nodes,
            "node_texts" => "$(data[06, :node_text])",
            "node_text_rotations" => pi * 0.5,
            "node_text_positions" => Point2f[(column_1 + column_1_width * 0.5, ((row_6 + row_6_height * 0.5) + (row_7 + row_7_height * 0.5)) * 0.5)],
            "node_text_widths" => column_1_width * (1 - node_padding * 2)
        ),
        "node_7" => Dict(
            "node_polygons" => Point2f[(column_2, row_2), (column_2 + column_2_width, row_2), (column_2 + column_2_width, row_2 + row_2_height), (column_2, row_2 + row_2_height)],
            "node_colors" => if grayboxes == true grayboxes_color else "white" end,
            "node_border_widths" => if grayboxes == true 0 else node_border_width end,
            "node_visibility" => previous_studies,
            "node_texts" => "$(data[07, :node_text])\n(n = $(data[07, :num]))\n$(data[08, :node_text])\n(n = $(data[08, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_2 + column_2_width * 0.5, row_2 + row_2_height * 0.5)],
            "node_text_widths" => column_2_width * (1 - node_padding * 2)
        ),
        "node_8" => Dict(
            "node_polygons" => Point2f[(column_3, row_2), (column_3 + column_3_width, row_2), (column_3 + column_3_width, row_2 + row_2_height), (column_3, row_2 + row_2_height)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[09, :node_text])\n$(data[10, :node_text])\n(n = $(data[10, :num]))\n$(data[11, :node_text])\n(n = $(data[11, :num]))\n$(data[12, :node_text])\n(n = $(data[12, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_3 + column_3_width * 0.5, row_2 + row_2_height * 0.5)],
            "node_text_widths" => column_3_width * (1 - node_padding * 2)
        ),
        "node_9" => Dict(
            "node_polygons" => Point2f[(column_4, row_2), (column_4 + column_4_width, row_2), (column_4 + column_4_width, row_2 + row_2_height), (column_4, row_2 + row_2_height)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[13, :node_text])\n$(data[14, :node_text])\n(n = $(data[14, :num]))\n$(data[15, :node_text])\n(n = $(data[15, :num]))\n$(data[16, :node_text])\n(n = $(data[16, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_4 + column_4_width * 0.5, row_2 + row_2_height * 0.5)],
            "node_text_widths" => column_4_width * (1 - node_padding * 2)
        ),
        "node_10" => Dict(
            "node_polygons" => Point2f[(column_3, row_3), (column_3 + column_3_width, row_3), (column_3 + column_3_width, row_3 + row_3_height), (column_3, row_3 + row_3_height)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[17, :node_text])\n(n = $(data[17, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_3 + column_3_width * 0.5, row_3 + row_3_height * 0.5)],
            "node_text_widths" => column_3_width * (1 - node_padding * 2)
        ),
        "node_11" => Dict(
            "node_polygons" => Point2f[(column_4, row_3), (column_4 + column_4_width, row_3), (column_4 + column_4_width, row_3 + row_3_height), (column_4, row_3 + row_3_height)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[18, :node_text])\n(n = $(data[18, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_4 + column_4_width * 0.5, row_3 + row_3_height * 0.5)],
            "node_text_widths" => column_4_width * (1 - node_padding * 2)
        ),
        "node_12" => Dict(
            "node_polygons" => Point2f[(column_3, row_4), (column_3 + column_3_width, row_4), (column_3 + column_3_width, row_4 + row_4_height), (column_3, row_4 + row_4_height)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[19, :node_text])\n(n = $(data[19, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_3 + column_3_width * 0.5, row_4 + row_4_height * 0.5)],
            "node_text_widths" => column_3_width * (1 - node_padding * 2)
        ),
        "node_13" => Dict(
            "node_polygons" => Point2f[(column_4, row_4), (column_4 + column_4_width, row_4), (column_4 + column_4_width, row_4 + row_4_height), (column_4, row_4 + row_4_height)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[20, :node_text])\n(n = $(data[20, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_4 + column_4_width * 0.5, row_4 + row_4_height * 0.5)],
            "node_text_widths" => column_4_width * (1 - node_padding * 2)
        ),
        "node_14" => Dict(
            "node_polygons" => Point2f[(column_3, row_5 + row_5_height * 0.25), (column_3 + column_3_width, row_5 + row_5_height * 0.25), (column_3 + column_3_width, row_5 + row_5_height - row_5_height * 0.25), (column_3, row_5 + row_5_height - row_5_height * 0.25)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[21, :node_text])\n(n = $(data[21, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_3 + column_3_width * 0.5, row_5 + row_5_height * 0.5)],
            "node_text_widths" => column_3_width * (1 - node_padding * 2)
        ),
        "node_15" => Dict(
            "node_polygons" => Point2f[(column_4, row_5), (column_4 + column_4_width, row_5), (column_4 + column_4_width, row_5 + row_5_height), (column_4, row_5 + row_5_height)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[22, :node_text])\n$(data[23, :node_text])\n(n = $(data[23, :num]))\n$(data[24, :node_text])\n(n = $(data[24, :num]))\n$(data[25, :node_text])\n(n = $(data[25, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_4 + column_4_width * 0.5, row_5 + row_5_height * 0.5)],
            "node_text_widths" => column_4_width * (1 - node_padding * 2)
        ),
        "node_16" => Dict(
            "node_polygons" => Point2f[(column_3, row_6), (column_3 + column_3_width, row_6), (column_3 + column_3_width, row_6 + row_6_height), (column_3, row_6 + row_6_height)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[26, :node_text])\n(n = $(data[26, :num]))\n$(data[27, :node_text])\n(n = $(data[27, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_3 + column_3_width * 0.5, row_6 + row_6_height * 0.5)],
            "node_text_widths" => column_3_width * (1 - node_padding * 2)
        ),
        "node_17" => Dict(
            "node_polygons" => Point2f[(column_3, row_7), (column_3 + column_3_width, row_7), (column_3 + column_3_width, row_7 + row_7_height), (column_3, row_7 + row_7_height)],
            "node_colors" => "white",
            "node_border_widths" => node_border_width,
            "node_visibility" => true,
            "node_texts" => "$(data[28, :node_text])\n(n = $(data[28, :num]))\n$(data[29, :node_text])\n(n = $(data[29, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_3 + column_3_width * 0.5, row_7 + row_7_height * 0.5)],
            "node_text_widths" => column_3_width * (1 - node_padding * 2)
        ),
        "node_18" => Dict(
            "node_polygons" => Point2f[(column_5, row_2), (column_5 + column_5_width, row_2), (column_5 + column_5_width, row_2 + row_2_height), (column_5, row_2 + row_2_height)],
            "node_colors" => if grayboxes == true grayboxes_color else "white" end,
            "node_border_widths" => if grayboxes == true 0 else node_border_width end,
            "node_visibility" => other_methods,
            "node_texts" => "$(data[30, :node_text])\n$(data[31, :node_text])\n(n = $(data[31, :num]))\n$(data[32, :node_text])\n(n = $(data[32, :num]))\n$(data[33, :node_text])\n(n = $(data[33, :num]))\n$(data[34, :node_text])\n(n = $(data[34, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_5 + column_5_width * 0.5, row_2 + row_2_height * 0.5)],
            "node_text_widths" => column_5_width * (1 - node_padding * 2)
        ),
        "node_19" => Dict(
            "node_polygons" => Point2f[(column_5, row_4), (column_5 + column_5_width, row_4), (column_5 + column_5_width, row_4 + row_4_height), (column_5, row_4 + row_4_height)],
            "node_colors" => if grayboxes == true grayboxes_color else "white" end,
            "node_border_widths" => if grayboxes == true 0 else node_border_width end,
            "node_visibility" => other_methods,
            "node_texts" => "$(data[35, :node_text])\n(n = $(data[35, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_5 + column_5_width * 0.5, row_4 + row_4_height * 0.5)],
            "node_text_widths" => column_5_width * (1 - node_padding * 2)
        ),
        "node_20" => Dict(
            "node_polygons" => Point2f[(column_6, row_4), (column_6 + column_6_width, row_4), (column_6 + column_6_width, row_4 + row_4_height), (column_6, row_4 + row_4_height)],
            "node_colors" => if grayboxes == true grayboxes_color else "white" end,
            "node_border_widths" => if grayboxes == true 0 else node_border_width end,
            "node_visibility" => other_methods,
            "node_texts" => "$(data[36, :node_text])\n(n = $(data[36, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_6 + column_6_width * 0.5, row_4 + row_4_height * 0.5)],
            "node_text_widths" => column_6_width * (1 - node_padding * 2)
        ),
        "node_21" => Dict(
            "node_polygons" => Point2f[(column_5, row_5 + row_5_height * 0.25), (column_5 + column_5_width, row_5 + row_5_height * 0.25), (column_5 + column_5_width, row_5 + row_5_height * 0.75), (column_5, row_5 + row_5_height * 0.75)],
            "node_colors" => if grayboxes == true grayboxes_color else "white" end,
            "node_border_widths" => if grayboxes == true 0 else node_border_width end,
            "node_visibility" => other_methods,
            "node_texts" => "$(data[37, :node_text])\n(n = $(data[37, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_5 + column_5_width * 0.5, row_5 + row_5_height * 0.5)],
            "node_text_widths" => column_5_width * (1 - node_padding * 2)
        ),
        "node_22" => Dict(
            "node_polygons" => Point2f[(column_6, row_5), (column_6 + column_6_width, row_5), (column_6 + column_6_width, row_5 + row_5_height), (column_6, row_5 + row_5_height)],
            "node_colors" => if grayboxes == true grayboxes_color else "white" end,
            "node_border_widths" => if grayboxes == true 0 else node_border_width end,
            "node_visibility" => other_methods,
            "node_texts" => "$(data[38, :node_text])\n$(data[39, :node_text])\n(n = $(data[39, :num]))\n$(data[40, :node_text])\n(n = $(data[40, :num]))\n$(data[41, :node_text])\n(n = $(data[41, :num]))",
            "node_text_rotations" => 0,
            "node_text_positions" => Point2f[(column_6 + column_6_width * 0.5, row_5 + row_5_height * 0.5)],
            "node_text_widths" => column_6_width * (1 - node_padding * 2)
        )
    )

    for (node, polygon) in node_dictionary
        color = node_dictionary[node]["node_colors"]
        border_width = node_dictionary[node]["node_border_widths"]
        visible = node_dictionary[node]["node_visibility"]
        text_position = node_dictionary[node]["node_text_positions"]
        text = node_dictionary[node]["node_texts"]
        text_rotation = node_dictionary[node]["node_text_rotations"]
        text_width = node_dictionary[node]["node_text_widths"]

        poly!(
            axis,
            polygon["node_polygons"],
            strokewidth=border_width,
            color=color,
            strokecolor=node_border_color,
            visible=visible
        )

        text!(
            axis,
            text_position,
            text=text,
            color=font_color,
            fontsize=font_size,
            font=font,
            word_wrap_width=text_width,
            visible=visible,
            rotation=text_rotation,
            justification=:center,
            align=(:center, :center),
        )
    end

    arrow_dictionary = Dict(
        "node_07 to _______" => Dict(
            "arrow_origins" => Point2f[(column_2 + column_2_width * 0.5, row_2)],
            "arrow_displacements" => Vec2f[(0,-(row_2_gap + row_3_height + row_3_gap + row_4_height + row_4_gap + row_5_height + row_5_gap + row_6_height + row_6_gap + row_7_height * 0.5))],
            "arrow_heads" => ' ',
            "arrow_visibilities" => previous_studies
        ),
        "_______ to node_17" => Dict(
            "arrow_origins" => Point2f[(column_2 + column_2_width * 0.5, row_7 + row_7_height * 0.5)],
            "arrow_displacements" => Vec2f[(column_2_width * 0.5 + column_2_gap - arrow_head_size * 0.5, 0)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => previous_studies
        ),
        "node_08 to node_09" => Dict(
            "arrow_origins" => Point2f[(column_3 + column_3_width, row_2 + row_2_height * 0.5)],
            "arrow_displacements" => Vec2f[(column_3_gap - arrow_head_size * 0.5, 0)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => true
        ),
        "node_08 to node_10" => Dict(
            "arrow_origins" => Point2f[(column_3 + column_3_width * 0.5, row_2)],
            "arrow_displacements" => Vec2f[(0, -row_2_gap + arrow_head_size * 0.5)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => true
        ),
        "node_10 to node_11" => Dict(
            "arrow_origins" => Point2f[(column_3 + column_3_width, row_3 + row_3_height * 0.5)],
            "arrow_displacements" => Vec2f[(column_3_gap - arrow_head_size * 0.5, 0)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => true
        ),
        "node_10 to node_12" => Dict(
            "arrow_origins" => Point2f[(column_3 + column_3_width * 0.5, row_3)],
            "arrow_displacements" => Vec2f[(0, -row_3_gap + arrow_head_size * 0.5)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => true
        ),
        "node_12 to node_13" => Dict(
            "arrow_origins" => Point2f[(column_3 + column_3_width, row_4 + row_4_height * 0.5)],
            "arrow_displacements" => Vec2f[(column_3_gap - arrow_head_size * 0.5, 0)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => true
        ),
        "node_12 to node_14" => Dict(
            "arrow_origins" => Point2f[(column_3 + column_3_width * 0.5, row_4)],
            "arrow_displacements" => Vec2f[(0, -row_4_gap - row_5_height * 0.25 + arrow_head_size * 0.5)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => true
        ),
        "node_14 to node_15" => Dict(
            "arrow_origins" => Point2f[(column_3 + column_3_width, row_5 + row_5_height * 0.5)],
            "arrow_displacements" => Vec2f[(column_3_gap - arrow_head_size * 0.5, 0)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => true
        ),
        "node_14 to node_16" => Dict(
            "arrow_origins" => Point2f[(column_3 + column_3_width * 0.5, row_5 + row_5_height * 0.25)],
            "arrow_displacements" => Vec2f[(0, -row_5_gap - row_5_height * 0.25 + arrow_head_size * 0.5)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => true
        ),
        "node_16 to node_17" => Dict(
            "arrow_origins" => Point2f[(column_3 + column_3_width * 0.5, row_6)],
            "arrow_displacements" => Vec2f[(0, -row_6_gap + arrow_head_size * 0.5)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => true
        ),
        "node_18 to node_19" => Dict(
            "arrow_origins" => Point2f[(column_5 + column_5_width * 0.5, row_2)],
            "arrow_displacements" => Vec2f[(0, -row_2_gap - row_3_gap - row_3_height + arrow_head_size * 0.5)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => other_methods
        ),
        "node_19 to node_20" => Dict(
            "arrow_origins" => Point2f[(column_5 + column_5_width, row_4 + row_4_height * 0.5)],
            "arrow_displacements" => Vec2f[(column_3_gap - arrow_head_size * 0.5, 0)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => other_methods
        ),
        "node_19 to node_21" => Dict(
            "arrow_origins" => Point2f[(column_5 + column_5_width * 0.5, row_4)],
            "arrow_displacements" => Vec2f[(0, -row_4_gap - row_5_height * 0.25 + arrow_head_size * 0.5)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => other_methods
        ),
        "node_21 to node_22" => Dict(
            "arrow_origins" => Point2f[(column_5 + column_5_width, row_5 + row_5_height * 0.5)],
            "arrow_displacements" => Vec2f[(column_3_gap - arrow_head_size * 0.5, 0)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => other_methods
        ),
        "node_21 to _______" => Dict(
            "arrow_origins" => Point2f[(column_5 + column_5_width * 0.5, row_5 + row_5_height * 0.25)],
            "arrow_displacements" => Vec2f[(0, -(row_5_gap + row_5_height * 0.25 + row_6_height * 0.5))],
            "arrow_heads" => ' ',
            "arrow_visibilities" => other_methods
        ),
        "_______ to node_16" => Dict(
            "arrow_origins" => Point2f[(column_5 + column_5_width * 0.5, row_6 + row_6_height * 0.5)],
            "arrow_displacements" => Vec2f[(-column_5_gap - column_4_gap - column_4_width - column_5_width * 0.5 + arrow_head_size * 0.5, 0)],
            "arrow_heads" => arrow_head,
            "arrow_visibilities" => other_methods
        ),
    )

    for (arrow, arrow_origin) in arrow_dictionary
        displacement = arrow_dictionary[arrow]["arrow_displacements"]
        arrow_head = arrow_dictionary[arrow]["arrow_heads"]
        visible = arrow_dictionary[arrow]["arrow_visibilities"]

        arrows!(
            axis,
            arrow_origin["arrow_origins"],
            displacement,
            linewidth=arrow_width,
            linecolor=arrow_color,
            arrowhead=arrow_head,
            arrowsize=arrow_head_size,
            visible=visible,
        )
    end

    return figure
end
