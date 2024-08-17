"""
    PRISMA.flow_diagram_df()::DataFrame

Return the template that is used to create the flow diagram as a `DataFrame`.

## Examples

You can either edit the template in a Julia program or save it as a CSV file.

```julia
using PRISMA

df = PRISMA.flow_diagram_df()

flow_diagram_save("flow_diagram.csv", df)

```

In order to add more databases or registers to the flow diagram, you must add them as 
another row. This can either be done by saving the template as a CSV file and editing 
it in a Julia program using the `DataFrames` package.

When you want to add a specific text to the a specific box the box must be specificied
in the box_num column. There are 22 boxes in the flow diagram. When you using the
`DataFrames` package, you can add the new row to the DataFrame using the `push!` function.

```julia
using PRISMA, DataFrames

df = PRISMA.flow_diagram_df()

# adding new Databases
push!(df, (8, "Database or Register 4", 150))
push!(df, (8, "Database or Register 5", 121))

# adding new reasons for exclusion
push!(df, (15, "Reason 4", 20))
push!(df, (15, "Reason 5", 10))
push!(df, (15, "Reason 6", 03))

println(df)

PRISMA.flow_diagram(df)
```

When you want to plot the data in the flow diagram, you can use the `PRISMA.flow_diagram`
function. If your data was saved as a CSV file, you can use must read it in using the
`DataFrames` package. 

```julia
using PRISMA, CSV, DataFrames

df = CSV.read("flow_diagram.csv", DataFrame)

PRISMA.flow_diagram(df)
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
    flow_diagram_read(fn::AbstractString; sheetname::AbstractString="", json_type::T, kwargs....)::DataFrame

reads the template data from a `CSV`, `XLSX`, `HTML`, or `JSON` file

## Arguments

- `fn::AbstractString`: the name of the file to read
- `sheetname::AbstractString="": the name of the sheet in the spreadsheet
- `json_type::T`: the type of the JSON file
- `kwargs...`: additional arguments to be passed to the underlying
`CSV.read`, `XLSX.readtable`, `HTMLTables.read`, and `JSON3.read` functions

## Returns

- `DataFrame`: the template dataframe

## Examples

```julia
using PRISMA: flow_diagram_save, flow_diagram_df, flow_diagram_read

flow_diagram_save("flow_diagram.csv", flow_diagram_df())
flow_diagram_save("flow_diagram.xlsx", flow_diagram_df())
flow_diagram_save("flow_diagram.json", flow_diagram_df())
flow_diagram_save("flow_diagram.html", flow_diagram_df())

flow_diagram_read("flow_diagram.csv")
flow_diagram_read("flow_diagram.xlsx")
flow_diagram_read("flow_diagram.json")
flow_diagram_read("flow_diagram.html")
```

"""
function flow_diagram_read(
    fn::AbstractString;
    sheetname::AbstractString="PRISMA Flow Diagram",
    json_type::T,
    kwargs...)::DataFrame

    return read_as_dataframe(fn; sheetname=sheetname, json_type=json_type, kwargs...)
end

"""
    PRISMA.FlowDiagram

Flow diagram type for PRISMA.jl

## Argument

- `dot::AbstractString`: The flow diagram written in Graphviz's DOT language

"""
@kwdef mutable struct FlowDiagram
    dot::AbstractString
end

function wrap_text(string::AbstractString)::String
    return replace(str_wrap(string, width=33), "\n" => "<br/>")
end

function group_labels(df::DataFrame)::DataFrame
    grouped::GroupedDataFrame = groupby(df, :box_num)
    grouped_labels::DataFrame = DataFrame(box_num=Int[], box_text=String[])

    for g in grouped
        number::Int = first(g.box_num)
        labels::Vector{String} = String[]

        for row in eachrow(g)
            text::String = ismissing(row.result) ? "<b>$(row.box_text)</b>" : row.box_text
            result::String = ismissing(row.result) ? "" : "<i>n</i>&nbsp;=&nbsp;$(row.result)"

            wrapped_text::String = row.box_num in TOP_BOXES || row.box_num in SIDE_BOXES ? text : wrap_text(text)
            wrapped_result::String = wrap_text(result)

            label::String = ismissing(row.result) ? wrapped_text : string(wrapped_text, "<br/>", wrapped_result)

            push!(labels, label)
        end

        group_label::String = join(labels, "<br/>")

        push!(grouped_labels, (number, group_label))
    end

    return grouped_labels
end

FLOW_DIAGRAM_TOP_MARGIN::Number = 1.4

FLOW_DIAGRAM_ROW_01::Number = 15.5
FLOW_DIAGRAM_ROW_02::Number = FLOW_DIAGRAM_ROW_01 - 1.2
FLOW_DIAGRAM_ROW_03::Number = FLOW_DIAGRAM_ROW_02 - FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_04::Number = FLOW_DIAGRAM_ROW_03 - FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_05::Number = FLOW_DIAGRAM_ROW_04 - FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_06::Number = FLOW_DIAGRAM_ROW_05 - FLOW_DIAGRAM_TOP_MARGIN
FLOW_DIAGRAM_ROW_07::Number = FLOW_DIAGRAM_ROW_06 - FLOW_DIAGRAM_TOP_MARGIN

FLOW_DIAGRAM_LEFT_MARGIN::Number = 2.65

FLOW_DIAGRAM_COL_01::Number = 01
FLOW_DIAGRAM_COL_02::Number = FLOW_DIAGRAM_COL_01 + FLOW_DIAGRAM_LEFT_MARGIN
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

const PREVIOUS_STUDIES_BOXES::Vector{Number} = [1, 7]
const OTHER_METHODS_BOXES::Vector{Number} = [3, 18, 19, 20, 21, 22]
const TOP_BOXES::Vector{Number} = [1, 2, 3]
const SIDE_BOXES::Vector{Number} = [4, 5, 6]
const GRAYBOXES::Vector{Number} = [1, 3, 7, 18, 19, 20, 21, 22]

"""
    PRISMA.flow_diagram(
        data::DataFrame=flow_diagram_df(),
        background_color::AbstractString="white",
        grayboxes::Bool=true,
        grayboxes_color::AbstractString="#f0f0f0",
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
        border_width::Union{AbstractString,Number}=1,
        border_color::AbstractString="black",
        font::AbstractString="Helvetica",
        font_color::AbstractString="black",
        font_size::Union{AbstractString,Number}=1,
        arrow_head::AbstractString="normal",
        arrow_size::Union{AbstractString,Number}=1,
        arrow_color::AbstractString="black",
        arrow_width::Union{AbstractString,Number}=1)::PRISMA.FlowDiagram

Generates the flow diagram figure from the flow diagram dataframe.

## Argument

- `data::DataFrame`: The flow diagram dataframe. Default is `flow_diagram_df()`.

## Keyword Arguments

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
- `font::String`: The font of the text. Default is `Helvetica`.
- `font_color::String`: The color of the text. Default is `black`.
- `font_size::Number`: The font size of the text. Default is `10`.
- `arrow_color::String`: The color of the arrows. Default is `black`.
- `arrow_width::Number`: The width of the arrows. Default is `1`.

## Returns

- `PRISMA.FlowDiagram`: The flow diagram figure.

## Example

```julia
using PRISMA, CSV, DataFrame

# create a template to edit the data in a csv
template_df::DataFrame = PRISMA.flow_diagram_df()
CSV.write("flow_diagram.csv", template_df)

# create a `DataFrame` from the csv
df::DataFrame = CSV.read("flow_diagram.csv", DataFrame)

# generate the flow diagram with the `DataFrame`
fd::PRISMA.FlowDiagram = PRISMA.flow_diagram(df, top_boxes_color="white")

# save the flow diagram
PRISMA.flow_diagram_save("flow_diagram.svg", fd)
```

"""
function flow_diagram(
    data::DataFrame=flow_diagram_df();
    background_color::AbstractString="white",
    grayboxes::Bool=true,
    grayboxes_color::AbstractString="#f0f0f0",
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
    border_width::Union{AbstractString,Number}=1,
    border_color::AbstractString="black",
    font::AbstractString="Helvetica",
    font_color::AbstractString="black",
    font_size::Union{AbstractString,Number}=10,
    arrow_head::AbstractString="normal",
    arrow_size::Union{AbstractString,Number}=1,
    arrow_color::AbstractString="black",
    arrow_width::Union{AbstractString,Number}=1)::PRISMA.FlowDiagram

    excluded_boxes::Set{Number} = Set{Number}()

    if !previous_studies
        data = filter(row -> !(row.box_num in PREVIOUS_STUDIES_BOXES), data)
        push!(excluded_boxes, 1, 7, 7.5)
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

    dot_lang::String = """
    digraph {
        graph [
            bgcolor="$background_color",
            layout=neato,
            splines=ortho
        ];
    """

    for row in eachrow(group_labels(data))
        box_color = "white"
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

        if grayboxes && row.box_num in GRAYBOXES
            box_color = grayboxes_color
            box_border_width = 0
        end

        pos = FLOW_DIAGRAM_POSITIONS[row.box_num]
        if !(row.box_num in excluded_boxes)
            dot_lang *= """
            $(row.box_num) [
                label=<$(row.box_text)>,
                tooltip="$(row.box_text)",
                shape=box,
                style="filled,$border_style",
                fillcolor="$box_color",
                penwidth=$(borders ? box_border_width : 0),
                color="$border_color",
                fontname="$font",
                fontcolor="$font_color",
                fontsize="$font_size",
                pos="$(pos.x),$(pos.y)!",
                width=2
            ];
            """
        end
    end

    invisible_nodes::Vector{Number} = [7.5, 21.5]
    for node in invisible_nodes
        if !(node in excluded_boxes)
            pos = FLOW_DIAGRAM_POSITIONS[node]
            dot_lang *= """
            $node [label="", height=0, width=0, pos="$(pos.x),$(pos.y)!"];
            """
        end
    end

    arrows::Vector{Tuple{Number,Number}} = [
        (7, 7.5),
        (7.5, 16),
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
        (21.5, 17)
    ]

    for (from, to) in arrows
        if !(from in excluded_boxes) && !(to in excluded_boxes)
            dot_lang *= """
            $from -> $to [
                arrowhead=$(from in Set([7, 21]) && to != 22 ? "none" : arrow_head),
                arrowsize="$arrow_size",
                color="$arrow_color",
                penwidth="$arrow_width"
            ];
            """
        end
    end

    dot_lang *= "}"

    return FlowDiagram(dot_lang)
end

"""
    PRISMA.flow_diagram_save(fn::AbstractString, fd::FlowDiagram; overwrite::Bool=false)::String

writes a `FlowDiagram` as either a file (i.e., any Graphviz supported format) or stdout

## Arguments

- `fn::AbstractString`: The name of the file to be saved.
- `fd::FlowDiagram`: The flow diagram to be saved.
- `overwrite::Bool=false`: Whether to overwrite the file if it already exists.

## Returns

- `String`: The path to the saved file.

## Examples

```julia
using PRISMA

fd = PRISMA.flow_diagram()

PRISMA.flow_diagram_save("flow_diagram.pdf", fd)
PRISMA.flow_diagram_save("flow_diagram.png", fd)
PRISMA.flow_diagram_save("flow_diagram.svg", fd)
```

"""
function flow_diagram_save(fn::AbstractString, fd::FlowDiagram; overwrite::Bool=false)::String
    check_overwrite(fn, overwrite)

    temp_gv::String = tempname() * ".gv"
    Base.Filesystem.write(temp_gv, fd.dot)
    try
        run(`$(neato()) $temp_gv -T$(split(fn, ".")[end]) -o $fn`)

        return fn
    catch e
        rethrow(e)
    finally
        rm(temp_gv, force=true)
    end
end

"""
    PRISMA.flow_diagram_save(fn::AbstractString, df::DataFrame; sheetname::AbstractString="PRISMA Flow Diagram", overwrite::Bool=false, kwargs...)::String

saves as the template for the flow diagram as a either a CSV, XLSX, HTML, or JSON file.

## Arguments

- `fn::AbstractString`: the name of the file to save
- `df::DataFrame`: the flow diagram to save
- `sheetname::AbstractString="PRISMA Flow Diagram"`: the name of the sheet in the spreadsheet
- `overwrite::Bool=false`: whether to overwrite the file if it already exists
- `kwargs...`: additional arguments to be passed to the underlying
`CSV.write`, `XLSX.writetable`, `HTMLTables.write`, and `JSON3.write` functions

## Returns

- `String`: the path to the saved file

## Examples

```julia
using PRISMA

df = PRISMA.flow_diagram_df()

PRISMA.flow_diagram_save("flow_diagram.csv", df)
PRISMA.flow_diagram_save("flow_diagram.xlsx", df)
PRISMA.flow_diagram_save("flow_diagram.html", df)
PRISMA.flow_diagram_save("flow_diagram.json", df)
```

"""
function flow_diagram_save(
    fn::AbstractString,
    df::DataFrame=flow_diagram_df();
    sheetname::AbstractString="PRISMA Flow Diagram",
    overwrite::Bool=false,
    kwargs...)::String

    check_overwrite(fn, overwrite)

    return save_dataframe(fn, df, sheetname; kwargs...)
end
