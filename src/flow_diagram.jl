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
    PRISMA.flow_diagram_template(out::Any="flow_diagram.csv")

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
    PRISMA.FlowDiagram

flow diagram type for PRISMA.jl

## Field

- `svg::AbstractString`: The SVG code for the flow diagram

"""
@kwdef mutable struct FlowDiagram
    svg::String
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
            text::String = row.box_text

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

FLOW_DIAGRAM_BOX_MARGIN::Number = 50
FLOW_DIAGRAM_BOX_HEIGHT::Number = 100
FLOW_DIAGRAM_BOX_WIDTH::Number = 250

FLOW_DIAGRAM_ROW_01::Number = 0
FLOW_DIAGRAM_ROW_02::Number = FLOW_DIAGRAM_ROW_01 + (FLOW_DIAGRAM_BOX_HEIGHT / 4) + FLOW_DIAGRAM_BOX_MARGIN / 2
FLOW_DIAGRAM_ROW_03::Number = FLOW_DIAGRAM_ROW_02 + FLOW_DIAGRAM_BOX_HEIGHT + FLOW_DIAGRAM_BOX_MARGIN
FLOW_DIAGRAM_ROW_04::Number = FLOW_DIAGRAM_ROW_03 + FLOW_DIAGRAM_BOX_HEIGHT + FLOW_DIAGRAM_BOX_MARGIN
FLOW_DIAGRAM_ROW_05::Number = FLOW_DIAGRAM_ROW_04 + FLOW_DIAGRAM_BOX_HEIGHT + FLOW_DIAGRAM_BOX_MARGIN
FLOW_DIAGRAM_ROW_06::Number = FLOW_DIAGRAM_ROW_05 + FLOW_DIAGRAM_BOX_HEIGHT + FLOW_DIAGRAM_BOX_MARGIN
FLOW_DIAGRAM_ROW_07::Number = FLOW_DIAGRAM_ROW_06 + FLOW_DIAGRAM_BOX_HEIGHT + FLOW_DIAGRAM_BOX_MARGIN

FLOW_DIAGRAM_COL_01::Number = 0
FLOW_DIAGRAM_COL_02::Number = FLOW_DIAGRAM_COL_01 + (FLOW_DIAGRAM_BOX_WIDTH / 8) + FLOW_DIAGRAM_BOX_MARGIN / 2
FLOW_DIAGRAM_COL_03::Number = FLOW_DIAGRAM_COL_02 + FLOW_DIAGRAM_BOX_WIDTH + FLOW_DIAGRAM_BOX_MARGIN
FLOW_DIAGRAM_COL_04::Number = FLOW_DIAGRAM_COL_03 + FLOW_DIAGRAM_BOX_WIDTH + FLOW_DIAGRAM_BOX_MARGIN
FLOW_DIAGRAM_COL_05::Number = FLOW_DIAGRAM_COL_04 + FLOW_DIAGRAM_BOX_WIDTH + FLOW_DIAGRAM_BOX_MARGIN
FLOW_DIAGRAM_COL_06::Number = FLOW_DIAGRAM_COL_05 + FLOW_DIAGRAM_BOX_WIDTH + FLOW_DIAGRAM_BOX_MARGIN

const FLOW_DIAGRAM_BOX_POSITIONS::Dict{Number,@NamedTuple{x::Number, y::Number}} = Dict(
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

const FLOW_DIAGRAM_ARROW_POSITIONS::Dict{String,LittleDict{Symbol,LittleDict}} = Dict(
    "07 to __" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[07.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[07.0].y + FLOW_DIAGRAM_BOX_HEIGHT
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[07.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[17.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
    ),
    "__ to 17" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[07.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[17.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[17.0].x,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[17.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        )
    ),
    "08 to 09" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[08.0].x + FLOW_DIAGRAM_BOX_WIDTH,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[08.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[09.0].x,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[09.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
    ),
    "08 to 10" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[08.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[08.0].y + FLOW_DIAGRAM_BOX_HEIGHT
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[10.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[10.0].y
        ),
    ),
    "10 to 11" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[10.0].x + FLOW_DIAGRAM_BOX_WIDTH,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[10.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[11.0].x,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[11.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
    ),
    "10 to 12" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[10.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[10.0].y + FLOW_DIAGRAM_BOX_HEIGHT
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[12.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[12.0].y
        ),
    ),
    "12 to 13" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[12.0].x + FLOW_DIAGRAM_BOX_WIDTH,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[12.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[13.0].x,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[13.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
    ),
    "12 to 14" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[12.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[12.0].y + FLOW_DIAGRAM_BOX_HEIGHT
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[14.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[14.0].y
        ),
    ),
    "14 to 15" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[14.0].x + FLOW_DIAGRAM_BOX_WIDTH,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[14.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[15.0].x,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[15.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
    ),
    "14 to 16" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[14.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[14.0].y + FLOW_DIAGRAM_BOX_HEIGHT
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[16.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[16.0].y
        ),
    ),
    "16 to 17" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[16.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[16.0].y + FLOW_DIAGRAM_BOX_HEIGHT
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[17.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[17.0].y
        ),
    ),
    "18 to 19" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[18.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[18.0].y + FLOW_DIAGRAM_BOX_HEIGHT
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[19.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[19.0].y
        ),
    ),
    "19 to 20" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[19.0].x + FLOW_DIAGRAM_BOX_WIDTH,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[19.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[20.0].x,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[20.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
    ),
    "19 to 21" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[19.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[19.0].y + FLOW_DIAGRAM_BOX_HEIGHT
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[21.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[21.0].y
        ),
    ),
    "21 to 22" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[21.0].x + FLOW_DIAGRAM_BOX_WIDTH,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[21.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[22.0].x,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[22.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
    ),
    "21 to __" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[21.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[21.0].y + FLOW_DIAGRAM_BOX_HEIGHT
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[21.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[16.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
    ),
    "__ to 16" => LittleDict(
        :start => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[21.0].x + FLOW_DIAGRAM_BOX_WIDTH / 2,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[16.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
        :stop => LittleDict(
            :x => FLOW_DIAGRAM_BOX_POSITIONS[16.0].x + FLOW_DIAGRAM_BOX_WIDTH,
            :y => FLOW_DIAGRAM_BOX_POSITIONS[16.0].y + FLOW_DIAGRAM_BOX_HEIGHT / 2
        ),
    ),
)

"""
    flow_diagram(
        data::DataFrame=flow_diagram_df(),
        background_color::AbstractString="white",
        boxes_color::AbstractString="white",
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
        border_width::Union{AbstractString,Number}=1,
        border_color::AbstractString="black",
        font::AbstractString="Helvetica",
        font_color::AbstractString="black",
        font_size::Union{AbstractString,Number}=1,
        arrow_head::AbstractString="normal",
        arrow_size::Union{AbstractString,Number}=1,
        arrow_color::AbstractString="black",
        arrow_width::Union{AbstractString,Number}=1)::FlowDiagram

generates the flow diagram figure from the flow diagram dataframe.

## Argument

- `data::DataFrame`: The flow diagram dataframe. Use the data from `flow_diagram_df()` if no data is provided.

## Keyword Arguments

- `background_color::String`: The background color of the flow diagram.
- `boxes_color::String`: The color of the boxes.
- `grayboxes::Bool`: Whether to show gray boxes.
- `grayboxes_color::String`: The color of the gray boxes.
- `top_boxes::Bool`: Whether to show top boxes.
- `top_boxes_border::Bool`: Whether to show top boxes border.
- `top_boxes_color::String`: The color of the top boxes.
- `side_boxes::Bool`: Whether to show side boxes.
- `side_boxes_border::Bool`: Whether to show side boxes border.
- `side_boxes_color::String`: The color of the side boxes.
- `previous_studies::Bool`: Whether to show previous studies.
- `other_methods::Bool`: Whether to show other methods.
- `box_border_width::Number`: The border width of the boxes.
- `box_border_color::String`: The border color of the boxes.
- `font::String`: The font of the text.
- `font_color::String`: The color of the text.
- `font_size::Number`: The font size of the text.
- `arrow_color::String`: The color of the arrows.
- `arrow_width::Number`: The width of the arrows.

## Returns

- `PRISMA.FlowDiagram`: The flow diagram figure.

## Example

```julia
using PRISMA

# create a template to edit the data in a csv
PRISMA.flow_diagram_template("flow_diagram.csv")

# create a `DataFrame` from the csv
df::DataFrame = PRISMA.flow_diagram_read("flow_diagram.csv")

# generate the flow diagram with the `DataFrame`
fd::PRISMA.FlowDiagram = PRISMA.flow_diagram(df)

# save the flow diagram
PRISMA.flow_diagram_save("flow_diagram.svg", fd)
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
    border_width::Number=2,
    border_color::AbstractString="black",
    font::AbstractString="Helvetica",
    font_color::AbstractString="black",
    font_size::Number=14,
    arrow_color::AbstractString="black",
    arrow_width::Number=2)::FlowDiagram

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

    min_x, min_y = Inf, Inf
    max_x, max_y = -Inf, -Inf

    d3_js::String = """
    import * as d3 from "d3";
    import jsdom from "jsdom";

    const document = new jsdom.JSDOM().window.document;

    const svg = d3
        .select(document.body).append("svg")
        .attr("xmlns", "http://www.w3.org/2000/svg")
        .attr("version", "1.1")
        .attr("width", "100%")
        .attr("height", "100%")
        .style("background-color", "$background_color");
    """

    for row in Base.eachrow(group_labels(data))
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

        pos = FLOW_DIAGRAM_BOX_POSITIONS[row.box_num]
        if !(row.box_num in excluded_boxes)
            if row.box_num in TOP_BOXES
                box_height = FLOW_DIAGRAM_BOX_HEIGHT / 4
            else
                box_height = FLOW_DIAGRAM_BOX_HEIGHT
            end

            if row.box_num in SIDE_BOXES
                box_width = FLOW_DIAGRAM_BOX_WIDTH / 8
            else
                box_width = FLOW_DIAGRAM_BOX_WIDTH
            end

            min_x = Base.min(min_x, pos.x)
            min_y = Base.min(min_y, pos.y)
            max_x = Base.max(max_x, pos.x + box_width)
            max_y = Base.max(max_y, pos.y + box_height)

            d3_js *= """
            const $box_name = svg
                .append("g")
                .attr("transform", "translate(0, 0)");
            $box_name
                .append("rect")
                .attr("x", $(pos.x))
                .attr("y", $(pos.y))
                .attr("width", $box_width)
                .attr("height", $box_height)
                .attr("fill", "$box_color")
                .attr("stroke", "$border_color")
                .attr("stroke-width", $(borders ? box_border_width : 0));
            $box_name
                .append("text")
                .attr("x", $(pos.x + box_width / 2))
                .attr("y", $(pos.y + box_height / 2))
                .attr("text-anchor", "middle")
                .attr("dominant-baseline", "middle")
                .attr("fill", "$font_color")
                .attr("font-family", "$font")
                .attr("font-size", $font_size)
                .text("$(row.box_text)")
                $(if row.box_num in SIDE_BOXES
                    """
                    .attr("transform", "rotate(-90, $(pos.x + box_width / 2), $(pos.y + box_height / 2))");
                    """
                else
                    ""
                end)
            """
        end
    end

    excluded_arrows::Set{String} = Set{String}()

    if !previous_studies
        Base.push!(excluded_arrows, "07 to __", "__ to 17", "16 to 17")
    end

    if !other_methods
        Base.push!(excluded_arrows, "19 to 20", "19 to 21", "21 to 22", "21 to __", "__ to 16")
    end

    for (key, pos) in FLOW_DIAGRAM_ARROW_POSITIONS
        if !(key in excluded_arrows)
            start::LittleDict = pos[:start]
            stop::LittleDict = pos[:stop]

            d3_js *= """
            svg
                .append("path")
                .attr("d", "M$(start[:x]),$(start[:y]) $(stop[:x]), $(stop[:y])")
                .attr("fill", "none")
                .attr("stroke", "$arrow_color")
                .attr("stroke-width", $arrow_width)
                $(if key in ["07 to __", "21 to __"]
                    ";"
                else
                    ".attr(\"marker-end\", \"url(#arrowhead)\");"
                end)
            """
        end
    end

    d3_js *= """
    svg
        .append("defs").append("marker")
        .attr("id", "arrowhead")
        .attr("markerWidth", 8)
        .attr("markerHeight", 8)
        .attr("refX", 7)
        .attr("refY", 4)
        .attr("orient", "auto")
        .append("polygon")
        .attr("points", "0,0 8,4 0,8")
        .attr("fill", "$arrow_color");
    """

    svg_width::Number = max_x - min_x
    svg_height::Number = max_y - min_y

    d3_js *= """
    svg
        .attr("viewBox", "$min_x $min_y $svg_width $svg_height")
        .attr("width", $svg_width)
        .attr("height", $svg_height);

    const svg_output = document.querySelector("svg").outerHTML;
    console.log(svg_output);
    """

    return FlowDiagram(svg=Base.read(`$(NodeJS.nodejs_cmd()) -e "$d3_js" --input-type=module`, String))
end

function Base.Multimedia.display(fd::FlowDiagram)::Nothing
    Base.Multimedia.display(Base.Multimedia.MIME("image/svg+xml"), fd)

    return nothing
end

function Base.show(io::IO, ::MIME"image/svg+xml", fd::FlowDiagram)::Nothing
    Base.print(io, fd)

    return nothing
end

"""
    flow_diagram_save(out, fd::FlowDiagram)::Nothing

saves a `FlowDiagram` as a `svg` format.

## Arguments

- `out::Any`: Accepts the same types as [`Base.write`](https://docs.julialang.org/en/v1/base/io-network/#Base.write)
- `fd::FlowDiagram`: The flow diagram as a `FlowDiagram`

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

PRISMA.flow_diagram_save(io, fd)

println(String(take!(io)))
```
"""
function flow_diagram_save(out::Any, fd::FlowDiagram)::Nothing
    Base.Filesystem.write(out, fd.svg)

    return nothing
end
