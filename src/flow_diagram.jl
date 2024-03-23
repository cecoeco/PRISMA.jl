"""
    flow_diagram_df()

Returns the flow diagram dataframe.
"""
function flow_diagram_df()
    names::Vector{String} = [
        "box_num",
        "box_url",
        "box_text",
        "num"
    ]
    rows::Vector{Tuple{Int64,String,String,Union{Int64,Missing}}} = [
        (
            1,
            "#previous_studies",
            "Previous studies",
            missing
        ),
        (
            2,
            "#new_studies",
            "Identification of new studies via databases and registers",
            missing
        ),
        (
            3,
            "#other_methods",
            "Identification of new studies via other methods",
            missing
        ),
        (
            4,
            "#identification",
            "Identification",
            missing
        ),
        (
            5,
            "#screening",
            "Screening",
            missing
        ),
        (
            6,
            "#included",
            "Included",
            missing
        ),
        (
            7,
            "#previous_studies",
            "Studies included in previous version of review",
            000
        ),
        (
            7,
            "#previous_reports",
            "Reports of studies included in previous version of review",
            000
        ),
        (
            8,
            "#records_identified",
            "Records identified from:",
            missing
        ),
        (
            8,
            "#database_1",
            "Database or Register 1",
            000
        ),
        (
            8,
            "#database_2",
            "Database or Register 2",
            000
        ),
        (
            8,
            "#database_3",
            "Database or Register 3",
            000
        ),
        (
            9,
            "#records_removed",
            "Records removed before screening:",
            missing
        ),
        (
            9,
            "#duplicate_removed",
            "Duplicate records removed",
            000
        ),
        (
            9,
            "#automation_tools",
            "Records marked as ineligible by automation tools",
            000
        ),
        (
            9,
            "#other_reasons",
            "Records removed for other reasons",
            000
        ),
        (
            10,
            "#records_screened",
            "Records screened",
            000
        ),
        (
            11,
            "#records_excluded",
            "Records excluded",
            000
        ),
        (
            12,
            "#reports_sought_for_retrieval",
            "Reports sought for retrieval",
            000
        ),
        (
            13,
            "#reports_not_retrieved",
            "Reports not retrieved",
            000
        ),
        (
            14,
            "#reports_assessed_for_eligibility",
            "Reports assessed for eligibility",
            000
        ),
        (
            15,
            "#reports_excluded",
            "Reports excluded:",
            missing
        ),
        (
            15,
            "#reason_1",
            "Reason 1",
            000
        ),
        (
            15,
            "#reason_2",
            "Reason 2",
            000
        ),
        (
            15,
            "#reason_3",
            "Reason 3",
            000
        ),
        (
            16,
            "#new_studies_included",
            "New studies included in review",
            000
        ),
        (
            16,
            "#new_reports_included",
            "Reports of new included studies",
            000
        ),
        (
            17,
            "#total_studies",
            "Total studies included in review",
            000
        ),
        (
            17,
            "#total_reports",
            "Reports of total included studies",
            000
        ),
        (
            18,
            "#records_identified_from",
            "Records identified from:",
            missing
        ),
        (
            18,
            "#websites",
            "Websites",
            000
        ),
        (
            18,
            "#organizations",
            "Organizations",
            000
        ),
        (
            18,
            "#citation_searching",
            "Citation searching",
            000
        ),
        (
            18,
            "#other",
            "Other",
            000
        ),
        (
            19,
            "#other_reports_sought_for_retrieval",
            "Reports sought for retrieval",
            000
        ),
        (
            20,
            "#other_reports_not_retrieved",
            "Reports not retrieved",
            000
        ),
        (
            21,
            "#other_reports_assessed_for_eligibility",
            "Reports assessed for eligibility",
            000
        ),
        (
            22,
            "#other_reports_excluded",
            "Reports excluded:",
            missing
        ),
        (
            22,
            "#other_reasons_1",
            "Reason 1",
            000
        ),
        (
            22,
            "#other_reasons_2",
            "Reason 2",
            000
        ),
        (
            22,
            "#other_reasons_3",
            "Reason 3",
            000
        )
    ]
    df::DataFrames.DataFrame = DataFrames.DataFrame(rows, names)
    return df
end

"""
    flow_diagram_csv(; save_location::String=Base.pwd(), filename::String="flow_diagram")

Writes the flow diagram dataframe to a CSV file.

# Arguments
- `save_location::String`: The directory to save the CSV file. Default is the current directory.
- `filename::String`: The name of the CSV file. Default is "flow_diagram".

# Returns
- `String`: The path to the CSV file.
"""
function flow_diagram_csv(; 
    save_location::String=Base.pwd(), 
    filename::String="flow_diagram"
)
    df::DataFrame = flow_diagram_df()
    path::String = Base.joinpath(save_location, "$filename.csv")
    CSV.write(path, df)
    return path
end

"""
    flow_diagram_json(; save_location::String=Base.pwd(), filename::String="flow_diagram")

Writes the flow diagram dataframe to a JSON file.

# Arguments
- `save_location::String`: The directory to save the JSON file.
- `filename::String`: The name of the JSON file.

# Returns
- `String`: The path to the JSON file.
"""
function flow_diagram_json(; 
    save_location::String=Base.pwd(), 
    filename::String="flow_diagram"
)
    df::DataFrame = flow_diagram_df()
    path::String = Base.joinpath(save_location, "$filename.json")
    dictionary::OrderedDict = DataStructures.OrderedDict(
        "box_num" => df[!, "box_num"],
        "box_url" => df[!, "box_url"],
        "box_text" => df[!, "box_text"],
        "num" => df[!, "num"]
    )
    JSON3.write(path, dictionary)
    return path
end

"""
    flow_diagram_xlsx(; save_location::String=pwd(), filename::String="flow_diagram", sheetname::String="flow_diagram")

Writes the flow diagram dataframe to an XLSX file.

# Arguments
- `save_location::String`: The directory to save the XLSX file.
- `filename::String`: The name of the XLSX file.
- `sheetname::String`: The name of the sheet in the XLSX file.

# Returns
- `String`: The path to the XLSX file.
"""
function flow_diagram_xlsx(; 
    save_location::String=pwd(), 
    filename::String="flow_diagram", 
    sheetname::String="flow_diagram"
)
    df::DataFrame = flow_diagram_df()
    path::String = Base.joinpath(save_location, "$filename.xlsx")
    XLSX.writetable(path, sheetname => df)
    return path
end

"""
    flow_diagram_read(; file::String="", excel_sheetname::Union{Nothing,String}=nothing, format_numbers::Bool=false)

Reads the flow diagram dataframe from a CSV, XLSX, or JSON file.

# Arguments
- `file::String`: The path to the CSV, XLSX, or JSON file.
- `excel_sheetname::Union{Nothing,String}`: The name of the sheet in the XLSX file.
- `format_numbers::Bool`: Whether to format numbers in the dataframe.

# Returns
- `DataFrame`: The flow diagram dataframe.
"""
function flow_diagram_read(; 
    file::String="", 
    excel_sheetname::Union{Nothing,String}=nothing, 
    format_numbers::Bool=false
)
    ext::String = Base.lowercase(Base.splitext(file)[2])
    if ext == ".csv"
        df = CSV.read(file, DataFrame)
        Base.println("DataFrame successfully read from $file")
    elseif ext == ".xlsx"
        if Base.isnothing(excel_sheetname)
            df = XLSX.readtable(file, "flow_diagram") |> DataFrame
        else
            df = XLSX.readtable(file, excel_sheetname) |> DataFrame
        end
        Base.println("DataFrame successfully read from $file")
    elseif ext == ".json"
        df = JSON3.read(file) |> DataFrame
        Base.println("DataFrame successfully read from $file")
    else
        Base.throw(Base.ArgumentError("Unsupported file format: $ext"))
    end
    if format_numbers == true
        df = format_df(df)
    end
    return df
end

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
        data::DataFrame=flow_diagram_df(),
        format_numbers::Bool=true,
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
        arrow_color::String="black",
        arrow_width::Number=1,
        plot::Bool=false,
        save::Bool=false,
        save_location::String=Base.pwd(),
        save_format::String="svg",
        filename::String="flow_diagram"
    )

Generates the flow diagram figure from the flow diagram dataframe.

# Arguments
- `data::DataFrame`: The flow diagram dataframe.
- `format_numbers::Bool`: Whether to format numbers in the flow diagram. Default is `true`.
- `background_color::String`: The background color of the flow diagram. Default is `white`.
- `grayboxes::Bool`: Whether to show gray boxes. Default is `true`.
- `grayboxes_color::String`: The color of the gray boxes. Default is `#f0f0f0`.
- `top_boxes::Bool`: Whether to show top boxes. Default is `true`.
- `top_boxes_border::Bool`: Whether to show top boxes border. Default is `false`.
- `top_boxes_color::String`: The color of the top boxes. Default is `#ffc000`.
- `side_boxes::Bool`: Whether to show side boxes. Default is `true`.
- `side_boxes_border::Bool`: Whether to show side boxes border. Default is `false`.
- `side_boxes_color::String`: The color of the side boxes. Default is `#95cbff`.
- `previous_studies::Bool`: Whether to show previous studies. Default is `true`.
- `other_methods::Bool`: Whether to show other methods. Default is `
- `box_border_width::Number`: The border width of the boxes. Default is `1`.
- `box_border_color::String`: The border color of the boxes. Default is `black`.
- `font::String`: The font of the text. Default is `Arial`.
- `font_color::String`: The color of the text. Default is `black`.
- `font_size::Number`: The font size of the text. Default is `10`.
- `arrow_color::String`: The color of the arrows. Default is `black`.
- `arrow_width::Number`: The width of the arrows. Default is `1`.
- `plot::Bool`: Whether to plot the flow diagram. Default is `false`.
- `save::Bool`: Whether to save the flow diagram. Default is `false`.
- `save_location::String`: The location to save the flow diagram. Default is `Base.pwd()`.
- `save_format::String`: The format to save the flow diagram. Default is `svg`.
- `filename::String`: The filename to save the flow diagram. Default is `flow_diagram`.
"""
function flow_diagram(;
    #data::DataFrame=flow_diagram_df(),
    format_numbers::Bool=true,
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
    arrow_color::String="black",
    arrow_width::Number=1,
    plot::Bool=false,
    save::Bool=false,
    save_location::String=Base.pwd(),
    save_format::String="svg",
    filename::String="flow_diagram"
)
    #data = JSON3.json(data)

    javascript_file_path::String = Base.joinpath(Base.pwd(), "assets", "flow_diagram.js")

    javascript_file_content::String = Base.read(javascript_file_path, String)

    embedded_javascript::String = (
        """
        $javascript_file_content

        flow_diagram(
            format_numbers =    $format_numbers,
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

    if save == true
        flow_diagram_save(
            figure=svg_string,
            name=filename,
            save_location=save_location,
            save_format=save_format
        )
    end

    if plot == true
        flow_diagram_plot(svg_string)
    end

    flow_diagram_string::FlowDiagram = FlowDiagram(svg_string)

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