const docstring_FlowDiagram::String = """
    PRISMA.FlowDiagram

flow diagram type for PRISMA.jl

## Field

- `dot::AbstractString`: The flow diagram written in Graphviz's DOT language

"""

const docstring_flow_diagram::String = 
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
        arrow_width::Union{AbstractString,Number}=1)::FlowDiagram

generates the flow diagram figure from the flow diagram dataframe.

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

const docstring_flow_diagram_df::String = 
"""
    PRISMA.flow_diagram_df()::DataFrame

returns the template that is used to create the flow diagram as a `DataFrame`.

## Returns

- `DataFrame`: the template dataframe

## Example

```jldoctest
julia> using PRISMA

julia> println(flow_diagram_df())
41×3 DataFrame
 Row │ box_num  box_text                           result  
     │ Int64    String                             Int64?  
─────┼─────────────────────────────────────────────────────
   1 │       1  Previous studies                   missing 
   2 │       2  Identification of new studies vi…  missing 
   3 │       3  Identification of new studies vi…  missing 
   4 │       4  Identification                     missing 
   5 │       5  Screening                          missing 
   6 │       6  Included                           missing 
   7 │       7  Studies included in previous ver…        0
   8 │       7  Reports of studies included in p…        0
   9 │       8  Records identified from:           missing 
  10 │       8  Database or Register 1                   0
  11 │       8  Database or Register 2                   0
  12 │       8  Database or Register 3                   0
  13 │       9  Records removed before screening:  missing 
  14 │       9  Duplicate records removed                0
  15 │       9  Records marked as ineligible by …        0
  16 │       9  Records removed for other reasons        0
  17 │      10  Records screened                         0
  18 │      11  Records excluded                         0
  19 │      12  Reports sought for retrieval             0
  20 │      13  Reports not retrieved                    0
  21 │      14  Reports assessed for eligibility         0
  22 │      15  Reports excluded:                  missing 
  23 │      15  Reason 1                                 0
  24 │      15  Reason 2                                 0
  25 │      15  Reason 3                                 0
  26 │      16  New studies included in review           0
  27 │      16  Reports of new included studies          0
  28 │      17  Total studies included in review         0
  29 │      17  Reports of total included studies        0
  30 │      18  Records identified from:           missing 
  31 │      18  Websites                                 0
  32 │      18  Organizations                            0
  33 │      18  Citation searching                       0
  34 │      18  Other                                    0
  35 │      19  Reports sought for retrieval             0
  36 │      20  Reports not retrieved                    0
  37 │      21  Reports assessed for eligibility         0
  38 │      22  Reports excluded:                  missing 
  39 │      22  Reason 1                                 0
  40 │      22  Reason 2                                 0
  41 │      22  Reason 3                                 0
```

"""

const docstring_flow_diagram_read::String = 
"""
    flow_diagram_read(fn::AbstractString)::DataFrame

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

julia> println(flow_diagram_read("flow_diagram.csv"))
41×3 DataFrame
 Row │ box_num  box_text                           result  
     │ Int64    String                             Int64?  
─────┼─────────────────────────────────────────────────────
   1 │       1  Previous studies                   missing 
   2 │       2  Identification of new studies vi…  missing 
   3 │       3  Identification of new studies vi…  missing 
   4 │       4  Identification                     missing 
   5 │       5  Screening                          missing 
   6 │       6  Included                           missing 
   7 │       7  Studies included in previous ver…        0
   8 │       7  Reports of studies included in p…        0
   9 │       8  Records identified from:           missing 
  10 │       8  Database or Register 1                   0
  11 │       8  Database or Register 2                   0
  12 │       8  Database or Register 3                   0
  13 │       9  Records removed before screening:  missing 
  14 │       9  Duplicate records removed                0
  15 │       9  Records marked as ineligible by …        0
  16 │       9  Records removed for other reasons        0
  17 │      10  Records screened                         0
  18 │      11  Records excluded                         0
  19 │      12  Reports sought for retrieval             0
  20 │      13  Reports not retrieved                    0
  21 │      14  Reports assessed for eligibility         0
  22 │      15  Reports excluded:                  missing 
  23 │      15  Reason 1                                 0
  24 │      15  Reason 2                                 0
  25 │      15  Reason 3                                 0
  26 │      16  New studies included in review           0
  27 │      16  Reports of new included studies          0
  28 │      17  Total studies included in review         0
  29 │      17  Reports of total included studies        0
  30 │      18  Records identified from:           missing 
  31 │      18  Websites                                 0
  32 │      18  Organizations                            0
  33 │      18  Citation searching                       0
  34 │      18  Other                                    0
  35 │      19  Reports sought for retrieval             0
  36 │      20  Reports not retrieved                    0
  37 │      21  Reports assessed for eligibility         0
  38 │      22  Reports excluded:                  missing 
  39 │      22  Reason 1                                 0
  40 │      22  Reason 2                                 0
  41 │      22  Reason 3                                 0
```

"""

const docstring_flow_diagram_save::String = 
"""
    PRISMA.flow_diagram_save(fn::AbstractString, fd::FlowDiagram)

writes a `FlowDiagram` as either a file (i.e., any Graphviz supported format)

## Arguments

- `fn::AbstractString`: The name of the file to be saved.
- `fd::FlowDiagram`: The flow diagram to be saved.

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

const docstring_flow_diagram_template::String =
"""
    PRISMA.flow_diagram_template(fn::AbstractString="flow_diagram.csv")

saves the template data to create a flow diagram as a CSV file.

## Arguments

- `fn::AbstractString`: the name of the file to saved

## Example

calling the function will create a CSV file called `flow_diagram.csv`:

```jldoctest
julia> using PRISMA

julia> flow_diagram_template()
"flow_diagram.csv"
```

"""