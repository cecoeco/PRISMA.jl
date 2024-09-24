include("flow_diagram_docstrings.jl")

"""
$docstring_flow_diagram_df
"""
function flow_diagram_df()::DataFrame
    cols::Vector{String} = ["box_num", "box_text", "result"]
    rows::Vector{Tuple{Int,String,Union{Int,Missing}}} = [
        (01, "Previous studies", missing),
        (02, "Identification of new studies via databases and registers", missing),
        (03, "Identification of new studies via other methods", missing),
        (04, "Identification", missing),
        (05, "Screening", missing),
        (06, "Included", missing),
        (07, "Studies included in previous version of review", 000),
        (07, "Reports of studies included in previous version of review", 000),
        (08, "Records identified from:", missing),
        (08, "Database or Register 1", 000),
        (08, "Database or Register 2", 000),
        (08, "Database or Register 3", 000),
        (09, "Records removed before screening:", missing),
        (09, "Duplicate records removed", 000),
        (09, "Records marked as ineligible by automation tools", 000),
        (09, "Records removed for other reasons", 000),
        (10, "Records screened", 000),
        (11, "Records excluded", 000),
        (12, "Reports sought for retrieval", 000),
        (13, "Reports not retrieved", 000),
        (14, "Reports assessed for eligibility", 000),
        (15, "Reports excluded:", missing),
        (15, "Reason 1", 000),
        (15, "Reason 2", 000),
        (15, "Reason 3", 000),
        (16, "New studies included in review", 000),
        (16, "Reports of new included studies", 000),
        (17, "Total studies included in review", 000),
        (17, "Reports of total included studies", 000),
        (18, "Records identified from:", missing),
        (18, "Websites", 000),
        (18, "Organizations", 000),
        (18, "Citation searching", 000),
        (18, "Other", 000),
        (19, "Reports sought for retrieval", 000),
        (20, "Reports not retrieved", 000),
        (21, "Reports assessed for eligibility", 000),
        (22, "Reports excluded:", missing),
        (22, "Reason 1", 000),
        (22, "Reason 2", 000),
        (22, "Reason 3", 000),
    ]

    return DataFrame(rows, cols)
end

"""
$docstring_flow_diagram_read
"""
function flow_diagram_read(fn::AbstractString="flow_diagram.csv")::DataFrame
    return CSV.read(fn, DataFrame)
end

"""
$docstring_flow_diagram_template
"""
function flow_diagram_template(fn::AbstractString="flow_diagram.csv")
    return CSV.write(fn, flow_diagram_df())
end

"""
    PRISMA.FlowDiagram

flow diagram type for PRISMA.jl

## Field

- `js::AbstractString`: The D3.js code 

"""
@kwdef mutable struct FlowDiagram
    js::String
end

const PREVIOUS_STUDIES_BOXES::Vector{Int} = [1, 7, 16]
const OTHER_METHODS_BOXES::Vector{Int} = [3, 18, 19, 20, 21, 22]
const TOP_BOXES::Vector{Int} = [1, 2, 3]
const SIDE_BOXES::Vector{Int} = [4, 5, 6]
const GRAY_BOXES::Vector{Int} = [1, 3, 7, 17, 18, 19, 20, 21, 22]

function wrap_text(string::AbstractString; max_length::Int=35)::String
    wrapped_lines::Vector{String} = Vector{String}()

    current_line::String = ""

    for word in Base.split(string)
        if Base.length(current_line) + Base.length(word) + 1 > max_length
            Base.push!(wrapped_lines, current_line)
            current_line = word
        else
            current_line *= Base.isempty(current_line) ? word : " " * word
        end
    end

    Base.push!(wrapped_lines, current_line)

    return Base.join(wrapped_lines, "<br/>")
end

function group_labels(df::DataFrame)::DataFrame
    grouped::GroupedDataFrame = DataFrames.groupby(df, :box_num)
    grouped_labels::DataFrame = DataFrame(box_num=Int[], box_text=String[])

    for g in grouped
        number::Int = Base.first(g.box_num)
        labels::Vector{String} = String[]

        for row in Base.eachrow(g)
            text::String = if row.box_num in TOP_BOXES || row.box_num in SIDE_BOXES
                "<b>$(row.box_text)</b>"
            else
                row.box_text
            end

            result::String = Base.ismissing(row.result) ? "" : "(<i>n</i> = $(row.result))"

            wrapped_text::String = if row.box_num in TOP_BOXES || row.box_num in SIDE_BOXES
                text
            else
                wrap_text(text)
            end

            wrapped_result::String = wrap_text(result)

            label::String = if Base.ismissing(row.result)
                wrapped_text
            elseif row.box_num in [7, 9, 10, 11, 12, 13, 14, 16, 17, 19, 20, 21]
                Base.string(wrapped_text, "<br/>", wrapped_result)
            else
                Base.string(wrapped_text, " ", wrapped_result)
            end

            Base.push!(labels, label)
        end

        group_label::String = Base.join(labels, "<br/>")

        Base.push!(grouped_labels, (number, group_label))
    end

    return grouped_labels
end

FLOW_DIAGRAM_TOP_MARGIN::Number = 120

FLOW_DIAGRAM_ROW_01::Number = 0
FLOW_DIAGRAM_ROW_02::Number = FLOW_DIAGRAM_ROW_01 + FLOW_DIAGRAM_TOP_MARGIN / 2
FLOW_DIAGRAM_ROW_03::Number = FLOW_DIAGRAM_ROW_02 + FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_04::Number = FLOW_DIAGRAM_ROW_03 + FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_05::Number = FLOW_DIAGRAM_ROW_04 + FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_06::Number = FLOW_DIAGRAM_ROW_05 + FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_07::Number = FLOW_DIAGRAM_ROW_06 + FLOW_DIAGRAM_TOP_MARGIN

FLOW_DIAGRAM_LEFT_MARGIN::Number = 220

FLOW_DIAGRAM_COL_01::Number = 0
FLOW_DIAGRAM_COL_02::Number = FLOW_DIAGRAM_COL_01 + FLOW_DIAGRAM_LEFT_MARGIN / 6
FLOW_DIAGRAM_COL_03::Number = FLOW_DIAGRAM_COL_02 + FLOW_DIAGRAM_LEFT_MARGIN
FLOW_DIAGRAM_COL_04::Number = FLOW_DIAGRAM_COL_03 + FLOW_DIAGRAM_LEFT_MARGIN
FLOW_DIAGRAM_COL_05::Number = FLOW_DIAGRAM_COL_04 + FLOW_DIAGRAM_LEFT_MARGIN
FLOW_DIAGRAM_COL_06::Number = FLOW_DIAGRAM_COL_05 + FLOW_DIAGRAM_LEFT_MARGIN

const FLOW_DIAGRAM_POSITIONS::Dict{Number,@NamedTuple{x::Number, y::Number}} = Dict(
    01.0 => (
        x=FLOW_DIAGRAM_COL_02,
        y=FLOW_DIAGRAM_ROW_01
    ),
    02.0 => (
        x=(FLOW_DIAGRAM_COL_03 + FLOW_DIAGRAM_COL_04) / 2,
        y=FLOW_DIAGRAM_ROW_01
    ),
    03.0 => (
        x=(FLOW_DIAGRAM_COL_05 + FLOW_DIAGRAM_COL_06) / 2,
        y=FLOW_DIAGRAM_ROW_01
    ),
    04.0 => (
        x=FLOW_DIAGRAM_COL_01,
        y=FLOW_DIAGRAM_ROW_02
    ),
    05.0 => (
        x=FLOW_DIAGRAM_COL_01,
        y=(FLOW_DIAGRAM_ROW_03 + FLOW_DIAGRAM_ROW_05) / 2
    ),
    06.0 => (
        x=FLOW_DIAGRAM_COL_01,
        y=(FLOW_DIAGRAM_ROW_06 + FLOW_DIAGRAM_ROW_07) / 2
    ),
    07.0 => (
        x=FLOW_DIAGRAM_COL_02,
        y=FLOW_DIAGRAM_ROW_02
    ),
    07.5 => (
        x=FLOW_DIAGRAM_COL_02,
        y=FLOW_DIAGRAM_ROW_06
    ),
    08.0 => (
        x=FLOW_DIAGRAM_COL_03,
        y=FLOW_DIAGRAM_ROW_02
    ),
    09.0 => (
        x=FLOW_DIAGRAM_COL_04,
        y=FLOW_DIAGRAM_ROW_02
    ),
    10.0 => (
        x=FLOW_DIAGRAM_COL_03,
        y=FLOW_DIAGRAM_ROW_03
    ),
    11.0 => (
        x=FLOW_DIAGRAM_COL_04,
        y=FLOW_DIAGRAM_ROW_03
    ),
    12.0 => (
        x=FLOW_DIAGRAM_COL_03,
        y=FLOW_DIAGRAM_ROW_04
    ),
    13.0 => (
        x=FLOW_DIAGRAM_COL_04,
        y=FLOW_DIAGRAM_ROW_04
    ),
    14.0 => (
        x=FLOW_DIAGRAM_COL_03,
        y=FLOW_DIAGRAM_ROW_05
    ),
    15.0 => (
        x=FLOW_DIAGRAM_COL_04,
        y=FLOW_DIAGRAM_ROW_05
    ),
    16.0 => (
        x=FLOW_DIAGRAM_COL_03,
        y=FLOW_DIAGRAM_ROW_06
    ),
    17.0 => (
        x=FLOW_DIAGRAM_COL_03,
        y=FLOW_DIAGRAM_ROW_07
    ),
    18.0 => (
        x=FLOW_DIAGRAM_COL_05,
        y=FLOW_DIAGRAM_ROW_02
    ),
    19.0 => (
        x=FLOW_DIAGRAM_COL_05,
        y=FLOW_DIAGRAM_ROW_04
    ),
    20.0 => (
        x=FLOW_DIAGRAM_COL_06,
        y=FLOW_DIAGRAM_ROW_04
    ),
    21.0 => (
        x=FLOW_DIAGRAM_COL_05,
        y=FLOW_DIAGRAM_ROW_05
    ),
    21.5 => (
        x=FLOW_DIAGRAM_COL_05,
        y=FLOW_DIAGRAM_ROW_07
    ),
    22.0 => (
        x=FLOW_DIAGRAM_COL_06,
        y=FLOW_DIAGRAM_ROW_05
    )
)

"""
$docstring_flow_diagram
"""
function flow_diagram(
    data::DataFrame=flow_diagram_df();
    background_color::AbstractString="white",
    boxes_color::AbstractString="white",
    gray_boxes::Bool=true,
    gray_boxes_color::AbstractString="#f0f0f0",
    top_boxes::Bool=true,
    top_boxes_borders::Bool=false,
    top_boxes_color::AbstractString="#ffc000",
    side_boxes::Bool=true,
    side_boxes_borders::Bool=false,
    side_boxes_color::AbstractString="#95cbff",
    previous_studies::Bool=true,
    other_methods::Bool=true,
    borders::Bool=true,
    border_width::Union{AbstractString,Number}=1,
    border_color::AbstractString="black",
    font::AbstractString="Helvetica",
    font_color::AbstractString="black",
    font_size::Union{AbstractString,Number}=8,
    arrow_head::AbstractString="normal",
    arrow_size::Union{AbstractString,Number}=1,
    arrow_color::AbstractString="black",
    arrow_width::Union{AbstractString,Number}=1)::FlowDiagram

    excluded_boxes::Set{Number} = Set{Number}()

    if !previous_studies
        data = filter(row -> !(row.box_num in PREVIOUS_STUDIES_BOXES), data)
        push!(excluded_boxes, 1, 7, 7.5, 16)
    end

    if !other_methods
        data = filter(row -> !(row.box_num in OTHER_METHODS_BOXES), data)
        push!(excluded_boxes, 3, 18, 19, 20, 21, 21.5, 22)
    end

    if !top_boxes
        data = filter(row -> !(row.box_num in TOP_BOXES), data)
        push!(excluded_boxes, 1, 2, 3)
    end

    if !side_boxes
        data = filter(row -> !(row.box_num in SIDE_BOXES), data)
        push!(excluded_boxes, 4, 5, 6)
    end

    javascript::String = """
    import * as d3 from "d3";
    import jsdom from "jsdom";

    const document = new jsdom.JSDOM().window.document;

    const svg = d3.select(document.body).append("svg")
        .attr("xmlns", "http://www.w3.org/2000/svg")
        .attr("version", "1.1")
        .attr("width", "100%")
        .attr("height", "100%")
        .attr("viewBox", "0 0 1200 800")
        .style("background-color", "$background_color");
    """

    for row in eachrow(group_labels(data))
        box_name = "box_$(row.box_num)"
        box_color = boxes_color
        box_border_width = border_width

        if top_boxes && row.box_num in TOP_BOXES
            box_color = top_boxes_color
            if !top_boxes_borders
                box_border_width = 0
            end
        end

        if side_boxes && row.box_num in SIDE_BOXES
            box_color = side_boxes_color
            if !side_boxes_borders
                box_border_width = 0
            end
        end

        if gray_boxes && row.box_num in GRAY_BOXES
            box_color = gray_boxes_color
            box_border_width = 0
        end

        pos = FLOW_DIAGRAM_POSITIONS[row.box_num]
        if !(row.box_num in excluded_boxes)
            javascript *= """
            const $box_name = svg.append("g")
                .attr("transform", "translate(0, 0)");
            $box_name.append("rect")
                .attr("x", $(pos.x))
                .attr("y", $(pos.y))
                .attr("width", $(row.box_num in SIDE_BOXES ? 25 : 200))
                .attr("height", $(row.box_num in TOP_BOXES ? 25 : 100))
                .attr("fill", "$box_color")
                .attr("stroke", "$border_color")
                .attr("stroke-width", $(borders ? box_border_width : 0))
            $box_name.append("text")
                .attr("x", $(pos.x))
                .attr("y", $(pos.y))
                .attr("text-anchor", "middle")
                .attr("dominant-baseline", "central")
                .attr("fill", "$font_color")
                .attr("font-family", "$font")
                .attr("font-size", $font_size)
                .text("$(row.box_text)");
            """
        end
    end

    return FlowDiagram(javascript)
end

function svg(fl::FlowDiagram)::String
    js::String = fl.js

    js *= """
    const svg_output = document.querySelector("svg").outerHTML;
    console.log(svg_output);
    """

    return Base.read(`$(NodeJS.nodejs_cmd()) -e "$js" --input-type=module`, String)
end

function Base.Multimedia.display(fd::FlowDiagram)::Nothing
    Base.Multimedia.display(Base.Multimedia.MIME("image/svg+xml"), svg(fd))

    return nothing
end

function Base.show(io::IO, ::MIME"image/svg+xml", fl::FlowDiagram)::Nothing
    Base.print(io, svg(fl))

    return nothing
end

"""
    flow_diagram_save(out, fd::FlowDiagram)::Nothing

saves a `FlowDiagram` as a `svg` format.

## Arguments

- `out`: Accepts the same types as [`Base.write`](https://docs.julialang.org/en/v1/base/io-network/#Base.write).
- `fd::FlowDiagram`: The flow diagram as D3.js script

## Examples

save a flow diagram to a file:

```julia
using PRISMA

fd::PRISMA.FlowDiagram = PRISMA.flow_diagram()

PRISMA.flow_diagram_save("flow_diagram.svg", fd)
```

save a flow diagram to an `IOBuffer`:

```julia
using PRISMA

io::IOBuffer = IOBuffer()

fd::PRISMA.FlowDiagram = PRISMA.flow_diagram()

PRISMA.flow_diagram_save(fd, io)

println(String(take!(io)))
```
"""
function flow_diagram_save(out, fd::FlowDiagram)::Nothing
    Base.Filesystem.write(out, svg(fd))

    return nothing
end
