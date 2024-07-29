"""
    PRISMA.flow_diagram_df()::DataFrame

Return the template that is used to create the flow diagram as a `DataFrame`.

## Examples

You can either edit the template in a Julia program or save it as a CSV file.

```julia
using PRISMA, CSV

df = PRISMA.flow_diagram_df()

CSV.write("flow_diagram.csv", df)

using PRISMA, DataFrames

df = PRISMA.flow_diagram_df()

df[3, "results"] = 200
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
    cols::Vector{String} = ["box_num", "box_lab", "results"]
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
    PRISMA.FlowDiagram

Flow diagram type for PRISMA.jl

## Argument

- `dot::AbstractString`: The flow diagram written in Graphviz's DOT language

"""
@kwdef mutable struct FlowDiagram
    dot::AbstractString
end

function group_labels(df::DataFrame)::DataFrame
    grouped::GroupedDataFrame = groupby(df, :box_num)
    grouped_labels::DataFrame = DataFrame(box_num=Int[], box_lab=String[])

    for g in grouped
        box_num::Int = first(g.box_num)
        box_lab::String = join(g.box_lab, "<br/>")
        push!(grouped_labels, (box_num, box_lab))
    end

    return grouped_labels
end

FLOW_DIAGRAM_ROW_01::Float64 = 12.7
FLOW_DIAGRAM_ROW_02::Float64 = 12
FLOW_DIAGRAM_ROW_03::Float64 = 11
FLOW_DIAGRAM_ROW_04::Float64 = 10
FLOW_DIAGRAM_ROW_05::Float64 = 09
FLOW_DIAGRAM_ROW_06::Float64 = 08
FLOW_DIAGRAM_ROW_07::Float64 = 07

FLOW_DIAGRAM_COL_01::Float64 = 01
FLOW_DIAGRAM_COL_02::Float64 = 04
FLOW_DIAGRAM_COL_03::Float64 = 07
FLOW_DIAGRAM_COL_04::Float64 = 10
FLOW_DIAGRAM_COL_05::Float64 = 13
FLOW_DIAGRAM_COL_06::Float64 = 16

const FLOW_DIAGRAM_POSITIONS::Dict{Float64,@NamedTuple{x::Float64, y::Float64}} = Dict(
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
        y=FLOW_DIAGRAM_ROW_06
    ),
    22.0 => (
        x=FLOW_DIAGRAM_COL_06,
        y=FLOW_DIAGRAM_ROW_05
    )
)

"""
    PRISMA.flow_diagram(
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
        border_width::Number=1,
        border_color::AbstractString="black",
        font::AbstractString="Helvetica",
        font_color::AbstractString="black",
        font_size::Number=1,
        arrow_head::AbstractString="normal",
        arrow_size::Number=1,
        arrow_color::AbstractString="black",
        arrow_width::Number=1)::PRISMA.FlowDiagram

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
    border_width::Number=1,
    border_color::AbstractString="black",
    font::AbstractString="Helvetica",
    font_color::AbstractString="black",
    font_size::Number=12,
    arrow_head::AbstractString="normal",
    arrow_size::Number=1,
    arrow_color::AbstractString="black",
    arrow_width::Number=1)::PRISMA.FlowDiagram

    excluded_nodes = Set{Number}()

    if !previous_studies
        data = filter(row -> !(row[:box_num] in [1, 7]), data)
        push!(excluded_nodes, 1, 7, 7.5)
    end

    if !other_methods
        data = filter(row -> !(row[:box_num] in [3, 18, 19, 20, 21, 22]), data)
        push!(excluded_nodes, 3, 18, 19, 20, 21, 21.5, 22)
    end

    if !top_boxes
        data = filter(row -> !(row[:box_num] in [1, 2, 3]), data)
        push!(excluded_nodes, 1, 2, 3)
    end

    if !side_boxes
        data = filter(row -> !(row[:box_num] in [4, 5, 6]), data)
        push!(excluded_nodes, 4, 5, 6)
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
        pos = FLOW_DIAGRAM_POSITIONS[row.box_num]
        if !(row.box_num in excluded_nodes)
            dot_lang *= """
            $(row.box_num) [
                label=<$(row.box_lab)>,
                shape=box,
                style="filled,$border_style",
                fixedsize="true",
                fillcolor="#aaffff",
                penwidth="$(borders ? border_width : 0)",
                color="$border_color",
                fontname="$font",
                fontcolor="$font_color",
                fontsize="$font_size",
                pos="$(pos.x),$(pos.y)!",
                width=2.5
            ];
            """
        end
    end

    invisible_nodes = [7.5, 21.5]
    for node in invisible_nodes
        if !(node in excluded_nodes)
            pos = FLOW_DIAGRAM_POSITIONS[node]
            dot_lang *= """
            $node [label="", height=0, width=0, pos="$(pos.x),$(pos.y)!"];
            """
        end
    end

    arrows = [
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
        if !(from in excluded_nodes) && !(to in excluded_nodes)
            dot_lang *= """
            $from -> $to [
                arrowhead=$(from in Set([7, 21]) ? "none" : arrow_head),
                arrowsize="$arrow_size",
                color=$arrow_color,
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
    if isfile(fn) && !overwrite
        return throw(ArgumentError("file $fn already exists"))
    end

    temp_gv::String = tempname() * ".gv"

    write(temp_gv, fd.dot)

    try
        run(`$(neato()) $temp_gv -T$(split(fn, ".")[end]) -o $fn`)

        return fn
    catch e
        rethrow(e)
    finally
        rm(temp_gv, force=true)
    end
end
