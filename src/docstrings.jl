const docstring_Checklist::String = 
"""
    PRISMA.Checklist

This types represents a PRISMA checklist in the form of a `DataFrame` and
the metadata of the paper that was used to generate it as a `LittleDict` or
an small ordered dictionary withs keys and values.

## Keyword Arguments

- `df::DataFrame`: the checklist as a `DataFrame`
- `metadata::LittleDict`: the metadata of the paper

## Examples

```julia
using PRISMA

cl::Checklist = checklist("paper.pdf")

title = cl.metadata["title"]
println(title)

pages = cl.metadata["pages"]
println(pages)
```

"""

const docstring_checklist::String = 
"""
    PRISMA.checklist(paper::AbstractString)::Checklist
    PRISMA.checklist(bytes::Vector{UInt8})::Checklist

Returns a completed PRISMA checklist as the type `Checklist`. The `Checklist`
type includes a completed checklist as a `DataFrame` and the metadata of the
paper as a `LittleDict`. The `paper` argument can be a path to a pdf file or
an array of bytes. This function uses the C++ library `Poppler` via `Poppler_jll`
to parse the pdf and the natural language processing functionality in Julia via
[`Flux.jl`](https://github.com/FluxML/Flux.jl) and
[`Transformers.jl`](https://github.com/chengchingwen/Transformers.jl) to 
find items from the checklist in the paper and populate the 
`Comments or location in manuscript` and `Yes/No/NA` columns in the `DataFrame` 
from `checklist_df()`.

The following metadata is parsed from the pdf file and stored in the `LittleDict` as:

- `"title"`: the title of the paper
- `"subject"`: the subject of the paper
- `"author"`: the author of the paper
- `"creator"`: the creator of the paper
- `"producer"`: the producer of the paper
- `"creation date"`: the date the paper was created
- `"modification date"`: the date the paper was last modified
- `"pages"`: the number of pages in the paper
- `"paper size"`: the size of the paper
- `"paper rotation"`: the rotation of the paper
- `"file size"`: the size of the pdf file
- `"optimized"`: whether the pdf was optimized
- `"pdf version"`: the version of the pdf

All keys and values in the dictionary ar eof type `String`.
If the parsing fails the value will be an empty string.

## Arguments

- `paper::AbstractString`: a path to a pdf file as a string
- `bytes::Vector{UInt8}`: the pdf data as an array of bytes

## Returns

- `Checklist`: a completed checklist with paper metadata

## Examples

Export a completed checklist to an Microsoft® Excel spreadsheet. Just make the sure the
file path end with `.xlsx`.

```julia
using PRISMA

clist = checklist("manuscript.pdf")

checklist_save("checklist.xlsx", clist)
```

It is also possible to view the completed checklist directly 
in a Julia program and using the `DataFrames.jl` package to 
edit the `DataFrame` directly to add values that the fubction 
could not find or to add new items or quick edits.

```julia
using PRISMA, DataFrames

df::DataFrame = checklist("manuscript.pdf").df

println(df)

df[02, "Yes/No/NA"] = "Yes"
df[09, "Yes/No/NA"] = "Yes"
df[10, "Yes/No/NA"] = "Yes"

```

"""

const docstring_checklist_df::String = 
"""
    PRISMA.checklist_df()::DataFrame

Returns a template PRISMA checklist as a `DataFrame`

## Examples

You can export the `DataFrame` to an Excel spreadsheet or CSV file and edit 
the checklist using a spreadsheet program. You can also edit the `DataFrame` 
directly in a Julia program using the DataFrames.jl package. 

```julia
using PRISMA

df = checklist_df()

checklist_save("checklist.csv",  df)
checklist_save("checklist.xlsx", df)
checklist_save("checklist.html", df; editable=true)
checklist_save("checklist.json", df)
```

```julia
using PRISMA

df = checklist_df()
df[3, "Location where item is reported"] = "Sysemtatic review is in the title."
df[3, "Location where item is reported"] = "The completed abastract is located on page one."
```

Additionally, the `checklist()` function uses `checklist_df()` as a template 
but takes a paper in PDF format, parses it using natural language processing 
via [`Flux.jl`](https://github.com/FluxML/Flux.jl) and 
[`Transformers.jl`](https://github.com/chengchingwen/Transformers.jl), and returns a 
completed checklist along with the paper's metadata, represented by the type `Checklist`.

"""

const docstring_checklist_read::String = 
"""
    checklist_read(fn::AbstractString; sheetname::AbstractString="2020 PRISMA Checklist", kwargs....)::DataFrame

reads the template data from a `CSV`, `XLSX`, `HTML`, or `JSON`

## Arguments

- `fn::AbstractString`: the name of the file to read
- `sheetname::AbstractString="2020 PRISMA Checklist"`: the name of the sheet in the spreadsheet
- `kwargs...`: additional arguments to be passed to the underlying
`CSV.read`, `XLSX.readtable`, `HTMLTables.read`, and `JSON3.read` functions

## Returns

- `DataFrame`: the template dataframe

## Examples

```julia
using PRISMA: checklist_save, checklist_df, checklist_read

checklist_save("checklist.csv",  checklist_df())
checklist_save("checklist.xlsx", checklist_df())
checklist_save("checklist.json", checklist_df())
checklist_save("checklist.html", checklist_df())

checklist_read("checklist.csv")
checklist_read("checklist.xlsx")
checklist_read("checklist.json")
checklist_read("checklist.html")
```
"""

const docstring_checklist_save_DataFrame::String = 
"""
    checklist_save(
        fn::AbstractString, 
        cl::Checklist; 
        sheetname::AbstractString="2020 PRISMA Checklist", 
        overwrite::Bool=false, 
        kwargs...
    )::String

saves as either `Checklist` a JSON, CSV, XLSX, or HTML.

## Arguments

- `fn::AbstractString`: the name of the file to save
- `df::DataFrame=checklist_df()`: the dataframe to save

## Keyword Arguments

- `sheetname::AbstractString="2020 PRISMA Checklist"`: the name of the sheet in the spreadsheet
- `overwrite::Bool`: whether to overwrite the file if it already exists
- `kwargs...`: arguments to be passed to the underlying `CSV.write`, `XLSX.writetable`, 
`HTMLTables.write`, and `JSON3.write` functions

## Returns

- `String`: the path to the saved file

## Examples

```julia
using PRISMA: checklist, checklist_save
using DataFrames: DataFrame

df::DataFrame = checklist_df()

checklist_save("checklist.csv",  df)
checklist_save("checklist.xlsx", df)
checklist_save("checklist.json", df)
checklist_save("checklist.html", df)

```

"""

const docstring_checklist_save_Checklist::String = 
"""
    checklist_save(
        fn::AbstractString, 
        cl::Checklist; 
        sheetname::AbstractString="2020 PRISMA Checklist", 
        overwrite::Bool=false, 
        kwargs...
    )::String

saves as either `Checklist` a JSON, CSV, XLSX, or HTML.

## Arguments

- `fn::AbstractString`: the name of the file to save
- `cl::Checklist`: the checklist to save

## Keyword Arguments

- `sheetname::AbstractString="2020 PRISMA Checklist"`: the name of the sheet in the spreadsheet
- `overwrite::Bool`: whether to overwrite the file if it already exists
- `kwargs...`: arguments to be passed to the underlying `CSV.write`, `XLSX.writetable`, 
`HTMLTables.write`, and `JSON3.write` functions

## Returns

- `String`: the path to the saved file

## Examples

```julia
using PRISMA: Checklist, checklist, checklist_save

clist::Checklist = checklist("manuscript.pdf")

checklist_save("checklist.csv",  clist)
checklist_save("checklist.xlsx", clist)
checklist_save("checklist.json", clist)
checklist_save("checklist.html", clist)
```

"""

const docstring_FlowDiagram::String = """
    PRISMA.FlowDiagram

Flow diagram type for PRISMA.jl

## Argument

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

const docstring_flow_diagram_df::String = 
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

const docstring_flow_diagram_read::String = 
"""
    flow_diagram_read(fn::AbstractString; sheetname::AbstractString="2020 PRISMA Flow Diagram", kwargs....)::DataFrame

reads the template data from a `CSV`, `XLSX`, `HTML`, or `JSON` file

## Arguments

- `fn::AbstractString`: the name of the file to read
- `sheetname::AbstractString="2020 PRISMA Flow Diagram": the name of the sheet in the spreadsheet
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

const docstring_flow_diagram_save_FlowDiagram::String = 
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

const docstring_flow_diagram_save_DataFrame::String =
"""
    PRISMA.flow_diagram_save(fn::AbstractString, df::DataFrame; sheetname::AbstractString="2020 PRISMA Flow Diagram", overwrite::Bool=false, kwargs...)::String

saves as the template for the flow diagram as a either a CSV, XLSX, HTML, or JSON file.

## Arguments

- `fn::AbstractString`: the name of the file to save
- `df::DataFrame`: the flow diagram to save
- `sheetname::AbstractString="2020 PRISMA Flow Diagram"`: the name of the sheet in the spreadsheet
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