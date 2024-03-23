using NodeJS
using JSON3

"""
    FlowDiagram

A struct that contains the SVG string of the flow diagram.

# Fields
- `svg_string`: The SVG string of the flow diagram.
"""
struct FlowDiagram
    svg_string::String
end

"""
    flow_diagram(;
    )

Generates the flow diagram figure from the flow diagram dataframe.

# Arguments

# Returns
- `FlowDiagram`: The flow diagram figure.
"""
function flow_diagram(;
    data::DataFrame=flow_diagram_df(),
    format_numbers::Bool=true,
    interactive::Bool=true,
    background_color::String="white",
    grayboxes::Bool=true,
    grayboxes_color::String="#f0f0f0",
    top_boxes::Bool=true,
    top_boxes_border::Bool=false,
    top_boxes_color::String="#ffc000",
    side_boxes::Bool=true,
    side_boxes_border::Bool=false,
    side_boxes_color::String="#95cbff",
    previous_studies::Bool=true,
    other_methods::Bool=true,
    box_border_width::Number=1,
    box_border_color::String="black",
    font::String="Arial",
    font_color::String="black",
    font_size::Number=10,
    font_weight::String="normal",
    arrow_color::String="black",
    arrow_width::Number=1,
    plot::Bool=false,
    save::Bool=false,
    save_location::String=Base.pwd(),
    save_format::String="svg",
    filename::String="flow_diagram"
)
    data = flow_diagram_json(data)

    json_data = Base.read(data, String)

    Base.rm(data)

    javascript_file_path::String = Base.joinpath(Base.pwd(), "assets", "flow_diagram.js")

    javascript_file_content::String = Base.read(javascript_file_path, String)

    embedded_javascript::String = (
        """
        $javascript_file_content
        
        flow_diagram(
            data =              $json_data,
            format_numbers =    $format_numbers,
            interactive =       $interactive,
            background_color = '$background_color',
            grayboxes =         $grayboxes,
            grayboxes_color =  '$grayboxes_color',
            top_boxes =         $top_boxes,
            top_boxes_border =  $top_boxes_border,
            top_boxes_color =  '$top_boxes_color',
            side_boxes =        $side_boxes,
            side_boxes_border = $side_boxes_border,
            side_boxes_color = '$side_boxes_color',
            previous_studies =  $previous_studies,
            other_methods =     $other_methods,
            box_border_width =  $box_border_width,
            box_border_color = '$box_border_color',
            font =             '$font',
            font_color =       '$font_color',
            font_size =         $font_size,
            font_weight =      '$font_weight',
            arrow_color =      '$arrow_color',
            arrow_width =       $arrow_width
        );

        const svgString = flow_diagram();
        console.log(svgString);
        """
    )

    file_directory::String = Base.dirname(Base.@__FILE__)

    temp_javascript_file::String = Base.joinpath(file_directory, "temporary_flow_diagram.js")

    Base.open(temp_javascript_file, "w") do file
        Base.write(file, embedded_javascript)
    end

    svg_string::String = Base.read(`$(NodeJS.nodejs_cmd()) $temp_javascript_file`, String)

    Base.rm(temp_javascript_file)

    flow_diagram_string::FlowDiagram = FlowDiagram(svg_string)

    if save == true
        flow_diagram_save(
            figure=flow_diagram_string,
            name=filename,
            save_location=save_location,
            save_format=save_format
        )
    end

    if plot == true
        flow_diagram_plot(flow_diagram_string)
    end

    return flow_diagram_string
end

"""
    flow_diagram_plot(figure::FlowDiagram)

Plots the flow diagram figure.

# Arguments
- `figure::FlowDiagram`: The flow diagram figure.

# Returns
- `plot`: The plot of the flow diagram figure.
"""
function flow_diagram_plot(figure::FlowDiagram=flow_diagram())
    plot = Base.display(MIME("image/svg+xml"), figure)
    return plot
end

"""
    flow_diagram_save(; figure::FlowDiagram=flow_diagram(), name::String="figure", save_location::String=Base.pwd(), save_format::String="svg")

Saves the flow diagram figure.

# Arguments
- `figure::FlowDiagram`: The flow diagram figure.
- `name::String`: The name of the figure.
- `save_location::String`: The directory to save the figure.
- `save_format::String`: The format to save the figure as.

# Returns
- `String`: The path to the saved figure.
"""
function flow_diagram_save(;
    figure::FlowDiagram=flow_diagram(),
    name::String="figure",
    save_location::String=Base.pwd(),
    save_format::String="svg"
)
    if save_format == "jpeg"
        return save_format = "jpg"
    end

    supported_formats::Vector{String} = ["png", "jpg", "svg", "pdf", "html"]

    if !(save_format in supported_formats)
        return Base.error("Unsupported save format: $save_format. Supported formats are: $(Base.join(supported_formats, ", "))")
    end

    path::String = Base.joinpath(save_location, "$name.$save_format")

    Base.save(path, figure)

    Base.println("Figure successfully saved to $(path)")

    return path
end