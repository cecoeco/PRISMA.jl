"""
    flow_diagram_df()::DataFrame

returns the template that is used to create the flow diagram as a `DataFrame`.

## Returns

- `DataFrame`: the template dataframe

## Example

```jldoctest
julia> using PRISMA

julia> isa(flow_diagram_df(), DataFrame)
true
```
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
    FlowDiagram(dot::AbstractString="")

The type for the flow diagram that can be plotted or saved as an image.

## Field

- `dot::AbstractString`: The flow diagram written in Graphviz's DOT language

"""
@kwdef mutable struct FlowDiagram
    dot::AbstractString = ""
end

const PREVIOUS_STUDIES_BOXES::Vector{Int} = [1, 7, 17]
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
            text::String = if row.box_num in Base.vcat(TOP_BOXES, SIDE_BOXES)
                "<b>$(row.box_text)</b>"
            else
                row.box_text
            end

            wrapped_text::String = if row.box_num in Base.vcat(TOP_BOXES, SIDE_BOXES)
                text
            else
                wrap_text(text)
            end

            result::String = Base.ismissing(row.result) ? "" : "(n&nbsp;=&nbsp;$(row.result))"

            label::String = if Base.ismissing(row.result)
                wrapped_text
            elseif row.box_num in [7, 9, 10, 11, 12, 13, 14, 16, 17, 19, 20, 21]
                Base.string(wrapped_text, "<br/>", result)
            else
                Base.string(wrapped_text, "&nbsp;", result)
            end

            Base.push!(labels, label)
        end

        group_label::String = Base.join(labels, "<br/>")

        Base.push!(grouped_labels, (number, group_label))
    end

    return grouped_labels
end

FLOW_DIAGRAM_TOP_MARGIN::Number = 1

FLOW_DIAGRAM_ROW_01::Number = 15.5
FLOW_DIAGRAM_ROW_02::Number = FLOW_DIAGRAM_ROW_01 - 0.75
FLOW_DIAGRAM_ROW_03::Number = FLOW_DIAGRAM_ROW_02 - FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_04::Number = FLOW_DIAGRAM_ROW_03 - FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_05::Number = FLOW_DIAGRAM_ROW_04 - FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_06::Number = FLOW_DIAGRAM_ROW_05 - FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_07::Number = FLOW_DIAGRAM_ROW_06 - FLOW_DIAGRAM_TOP_MARGIN

FLOW_DIAGRAM_LEFT_MARGIN::Number = 2.5

FLOW_DIAGRAM_COL_01::Number = 01
FLOW_DIAGRAM_COL_02::Number = FLOW_DIAGRAM_COL_01 + 1.25
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
        y=FLOW_DIAGRAM_ROW_07
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
        y=FLOW_DIAGRAM_ROW_06
    ),
    22.0 => (
        x=FLOW_DIAGRAM_COL_06,
        y=FLOW_DIAGRAM_ROW_05
    )
)

"""
    flow_diagram(
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
        border_style::AbstractString="solid",
        border_width::Number=1,
        border_color::AbstractString="black",
        font::AbstractString="Helvetica",
        font_color::AbstractString="black",
        font_size::Number=8,
        arrow_head::AbstractString="normal",
        arrow_size::Number=1,
        arrow_color::AbstractString="black",
        arrow_width::Number=1)::FlowDiagram

generates the flow diagram figure from the flow diagram dataframe.

## Argument

- `data::DataFrame`: The data used to generate the flow diagram. 
This function will use the `DataFrame` returned by `flow_diagram_df`, if no data is provided.

## Keyword Arguments

- `background_color::String`: the background color of the flow diagram.
- `boxes_color::String`: the color of the boxes.
- `gray_boxes::Bool`: whether to show gray boxes.
- `gray_boxes_color::String`: the color of the gray boxes.
- `top_boxes::Bool`: whether to show top boxes.
- `top_boxes_border::Bool`: whether to show top boxes border.
- `top_boxes_color::String`: the color of the top boxes.
- `side_boxes::Bool`: whether to show side boxes.
- `side_boxes_border::Bool`: whether to show side boxes border.
- `side_boxes_color::String`: the color of the side boxes.
- `previous_studies::Bool`: whether to show previous studies.
- `other_methods::Bool`: whether to show other methods.
- `borders::Bool=true`: whether to show borders.
- `border_style::String="solid"`: the border style of the boxes.
- `border_width::Number=1`: the border width of the boxes.
- `border_color::String="black"`: the border color of the boxes.
- `font::String="Helvetica"`: the font of the text.
- `font_color::String="black"`: the color of the text.
- `font_size::Number=8`: the font size of the text.
- `arrow_head::String="normal"`: the arrow head of the arrows.
- `arrow_size::Number=1`: the arrow size of the arrows.
- `arrow_color::String="black"`: the arrow color of the arrows.
- `arrow_width::Number=1`: the arrow width of the arrows.

## Returns

- `FlowDiagram`: The flow diagram figure.

## Example

```julia
using PRISMA

# create a template to edit the data in a csv
flow_diagram_template("flow_diagram.csv")

# create a `DataFrame` from the csv
df = flow_diagram_read("flow_diagram.csv")

# generate the flow diagram with the `DataFrame`
fd = flow_diagram(df)

# plot the flow diagram in the plot panel with `display`
display(fd)

# save the flow diagram
flow_diagram_save("flow_diagram.svg", fd)
```
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
    border_style::AbstractString="solid",
    border_width::Number=1,
    border_color::AbstractString="black",
    font::AbstractString="Helvetica",
    font_color::AbstractString="black",
    font_size::Number=8,
    arrow_head::AbstractString="normal",
    arrow_size::Number=1,
    arrow_color::AbstractString="black",
    arrow_width::Number=1)::FlowDiagram

    excluded_boxes::Set{Number} = Set{Number}()

    if !previous_studies
        data = Base.filter(row -> !(row.box_num in PREVIOUS_STUDIES_BOXES), data)
        Base.push!(excluded_boxes, 1, 7, 7.5, 17)
    end

    if !other_methods
        data = Base.filter(row -> !(row.box_num in OTHER_METHODS_BOXES), data)
        Base.push!(excluded_boxes, 3, 18, 19, 20, 21, 21.5, 22)
    end

    if !top_boxes
        data = Base.filter(row -> !(row.box_num in TOP_BOXES), data)
        Base.push!(excluded_boxes, 1, 2, 3)
    end

    if !side_boxes
        data = Base.filter(row -> !(row.box_num in SIDE_BOXES), data)
        Base.push!(excluded_boxes, 4, 5, 6)
    end

    dot::String = """
    digraph {
        graph [
            bgcolor="$background_color",
            layout=neato,
            splines=ortho
        ];
    """

    for row in Base.eachrow(group_labels(data))
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

        box_pos::NamedTuple = FLOW_DIAGRAM_POSITIONS[row.box_num]
        if !(row.box_num in excluded_boxes)
            dot *= """
            $(row.box_num) [
                label=<$(row.box_text)>,
                shape=box,
                style="filled,$border_style",
                fillcolor="$box_color",
                penwidth=$(borders ? box_border_width : 0),
                color="$border_color",
                fontname="$font",
                fontcolor="$font_color",
                fontsize="$font_size",
                pos="$(box_pos.x),$(box_pos.y)!",
                width=$(row.box_num in SIDE_BOXES ? 0 : row.box_num in [2, 3] ? 4.5 : 2),
                height=$(row.box_num in TOP_BOXES ? 0 : row.box_num in [4, 6] ? 1.5 : row.box_num in [5] ? 2 : 0),
            ];
            """
        end
    end

    invisible_nodes::Vector{Number} = [7.5, 21.5]
    for node in invisible_nodes
        if !(node in excluded_boxes)
            box_pos::NamedTuple = FLOW_DIAGRAM_POSITIONS[node]
            dot *= """
            $node [label="", height=0, width=0, pos="$(box_pos.x),$(box_pos.y)!"];
            """
        end
    end

    arrows::Vector{Tuple{Number,Number}} = [
        (7, 7.5),
        (7.5, 17),
        (8, 9),
        (8, 10),
        (10, 11),
        (10, 12),
        (12, 13),
        (12, 14),
        (14, 15),
        (14, 16),
        (16, 17),
        (18, 19),
        (19, 20),
        (19, 21),
        (21, 22),
        (21, 21.5),
        (21.5, 16)
    ]

    for (from, to) in arrows
        if !(from in excluded_boxes) && !(to in excluded_boxes)
            dot *= """
            $from -> $to [
                arrowhead=$(from in Set([7, 21]) && to != 22 ? "none" : arrow_head),
                arrowsize="$arrow_size",
                color="$arrow_color",
                penwidth="$arrow_width"
            ];
            """
        end
    end

    dot *= "}"

    return FlowDiagram(dot=dot)
end

function bytes(fd::FlowDiagram, format::AbstractString="svg")
    temp_gv::String = Base.Filesystem.tempname() * ".gv"
    Base.Filesystem.write(temp_gv, fd.dot)
    try
        return Base.read(`$(Graphviz_jll.neato()) $temp_gv -T$format`, String)
    catch ex
        Base.rethrow(ex)
    finally
        Base.Filesystem.rm(temp_gv, force=true)
    end
end

function Base.show(io::IO, fd::FlowDiagram)::Nothing
    Base.print(io, fd.dot)

    return nothing
end

function Base.show(io::IO, ::MIME"text/vnd.graphviz", fd::FlowDiagram)::Nothing
    Base.print(io, MIME("text/vnd.graphviz"), fd.dot)

    return nothing
end

function Base.show(io::IO, ::MIME"image/png", fd::FlowDiagram)::Nothing
    Base.print(io, bytes(fd, "png"))

    return nothing
end

function Base.show(io::IO, ::MIME"image/svg+xml", fd::FlowDiagram)::Nothing
    Base.print(io, bytes(fd, "svg"))

    return nothing
end

function Base.show(io::IO, ::MIME"application/pdf", fd::FlowDiagram)::Nothing
    Base.print(io, bytes(fd, "pdf"))

    return nothing
end

function Base.Multimedia.display(fd::FlowDiagram)::Nothing
    Base.Multimedia.display(
        Base.Multimedia.MIME("image/svg+xml"),
        bytes(fd, "svg")
    )

    return nothing
end

"""
    flow_diagram_read(fn::AbstractString="flow_diagram.csv")::DataFrame

reads the template data from a `CSV` file

## Arguments

- `fn::AbstractString`: the name of the file to read

## Returns

- `DataFrame`: the template dataframe

## Example

```jldoctest
julia> using PRISMA

julia> flow_diagram_template()
"flow_diagram.csv"

julia> isa(flow_diagram_read("flow_diagram.csv"), DataFrame)
true
```

"""
function flow_diagram_read(fn::AbstractString="flow_diagram.csv")::DataFrame
    return CSV.read(fn, DataFrame)
end

"""
    flow_diagram_template(out::Any="flow_diagram.csv")

saves the template data to create a flow diagram as a CSV file.

## Arguments

- `out::Any`: Accepts the same types as [`CSV.write`](https://csv.juliadata.org/stable/writing.html#CSV.write)

## Example

calling the function will create a CSV file called `flow_diagram.csv`:

```jldoctest
julia> using PRISMA

julia> flow_diagram_template()
"flow_diagram.csv"
```

"""
function flow_diagram_template(out::Any="flow_diagram.csv")
    return CSV.write(out, flow_diagram_df())
end

"""
    flow_diagram_save(fn::AbstractString, fd::FlowDiagram)

writes a `FlowDiagram` as either a file (i.e., any Graphviz supported format)

## Arguments

- `fn::AbstractString`: The name of the file to be saved.
- `fd::FlowDiagram`: The flow diagram to be saved.

## Returns

- `String`: The path to the saved file.

## Examples

```julia
using PRISMA

fd = flow_diagram()

flow_diagram_save("flow_diagram.pdf", fd)
flow_diagram_save("flow_diagram.png", fd)
flow_diagram_save("flow_diagram.svg", fd)
```
"""
function flow_diagram_save(fn::AbstractString, fd::FlowDiagram)
    temp_gv::String = Base.Filesystem.tempname() * ".gv"
    Base.Filesystem.write(temp_gv, fd.dot)
    try
        Base.run(`$(Graphviz_jll.neato()) $temp_gv -T$(Base.split(fn, ".")[end]) -o $fn`)
    catch ex
        Base.rethrow(ex)
    finally
        Base.Filesystem.rm(temp_gv, force=true)
    end
end
