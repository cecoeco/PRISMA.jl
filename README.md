# PRISMA.jl

<br>
<div align="center">
<img src="docs/src/assets/logo.svg" width="20%">
</div>
<br>

PRISMA.jl is a Julia package and [web application]() for generating checklists and flow diagrams based on the [2020 **P**referred **R**eporting **I**tems for **S**ystematic **R**eviews and **M**eta-**A**nalyses (PRISMA) statement (Page et al., 2021).](https://doi.org/10.1186/s13643-021-01626-4)

## :book: Documentation

<div>
<a href="https://cecoeco.github.io/PRISMA.jl/stable/"><img src="https://img.shields.io/badge/docs-stable-royalblue.svg" alt="Documentation Stable" /></a>
<a href="https://cecoeco.github.io/PRISMA.jl/dev/"><img src="https://img.shields.io/badge/docs-dev-royalblue.svg" alt="Documentation Dev"></a>
</div>

## :arrow_down: Installation

```julia
using Pkg; Pkg.add("PRISMA")
```

## Examples

The `flow_diagram_df` function is needed to create flow diagram. It has three columns: `"box_num"`, `"box_lab"`, `"results"`. The `"box_num"` column determines what box the data belongs to. A `"box_label"` would be the title of the box or an exclusion reason, and the `"results"` is the number of records that was excluded, so it must have an adjacent `"box_label"`. This `DataFrame` that is returned from `flow_diagram_df` can be saved as a data file then be read back into a Julia program using the `DataFrames` package or it can be directly modified in a Julia program using functions from `DataFrames` like `push!`:

```julia
using PRISMA: flow_diagram
using DataFrames: DataFrame, push!
using CSV, HTMLTables, XLSX

df::DataFrame = flow_diagram_df()

# adding new Databases
push!(df, (8, "Database or Register 4", 150))
push!(df, (8, "Database or Register 5", 121))

# adding new reasons for exclusion
push!(df, (15, "Reason 4", 20))
push!(df, (15, "Reason 5", 10))
push!(df, (15, "Reason 6", 03))

println(df)

# export the data as a CSV to edit then read it back to a DataFrame
csv_path::String = "flow_diagram.csv"
CSV.write(csv_path, df)
csv_df::DataFrame = CSV.read(csv_path, DataFrame)

println(csv_df)

# export the data as a HTML table to edit then read it back to a DataFrame
html_path::String = "flow_diagram.html"
HTMLTables.write(html_path, df)
html_df::DataFrame = HTMLTables.read(html_path, DataFrame)

println(html_df)

# export the data as a Excel spreadsheet to edit then read it back to a DataFrame
xlsx_path::String = "flow_diagram.xlsx"
sheetname::String = "flow_diagram"
XLSX.writetable(xlsx_path, sheetname => df)
xlsx_df::DataFrame = DataFrame(XLSX.readtable(xlsx_path, sheetname))

println(xlsx_df)
```

The `FlowDiagram` can be saved as any format support by `Graphviz_jll` using the `flow_diagram_save` the only catch is the file path should end with the extension of the desired format:

```julia
using PRISMA: FlowDiagram, flow_diagram

fd::FlowDiagram = flow_diagram()

# saves that flow diagram as an SVG
flow_diagram_save("flow_diagram.svg", fd)

# saves that flow diagram as a PNG
flow_diagram_save("flow_diagram.png", fd)
```

The look of the `FlowDiagram` can be edited assigning new values to each of the following keyword arguments of the `flow_diagram` function: `arrow_color`, `arrow_head`, `arrow_size`, `arrow_width`, `background_color`, `border_color`, `border_style`, `border_width`, `borders`, `font`, `font_color`, `font_size`, `grayboxes`, `grayboxes_color`, `other_methods`, `previous_studies`, `side_boxes`, `side_boxes_borders`, `side_boxes_color`, `top_boxes`, `top_boxes_borders`, `top_boxes_color`. The amount of arguments allows for the `FlowDiagram` to be high customizable and variable:

```julia
using PRISMA: FlowDiagram, flow_diagram, flow_diagram_save

# flow diagram with default styling
example_01::FlowDiagram = flow_diagram()

# flow diagram with custom styling
example_02::FlowDiagram = flow_diagram(
    arrow_color="#111111",
    arrow_head="Vee",
    arrow_width=2,
    border_color="#111111",
    border_width=2,
    font="Helvetica",
    font_color="#111111",
    font_size=10,
    grayboxes=false,
    previous_studies=false,
    side_boxes_borders=true,
    side_boxes_color="white",
    top_boxes_borders=true,
    top_boxes_color="white"
)

flow_diagram_save("example_01.svg", example_01)
flow_diagram_save("example_02.svg", example_02)

```

The flow diagram with default styling:

![flow diagram with default styling](docs/src/assets/figure.svg)

The flow diagram with custom styling:

![flow diagram with custom styling](docs/src/assets/figure.svg)

Creating a completed checklist from a paper and saving the results to a spreadsheet:

```julia
using PRISMA: Checklist, checklist
using DataStructures: LittleDict
using XLSX: writetable

clist::Checklist = checklist("manuscript.pdf")

println(clist)

clist_metadata::LittleDict = clist.metadata

println(clist_metadata)

title::String = clist_metadata["title"]

println(title)

writetable("$title.xlsx", title => clist.df)
```

The `checklist_df` function can be used to create spreadsheet files that can be edited outside Julia programs:

```julia
using PRISMA: checklist_df
using DataFrames: DataFrame
using XLSX: writetable

clist_template::DataFrame = checklist_df()

println(clist_template)

writetable("PRISMA_checklist.xlsx", "sheet_1" => clist_template)
```

The `DataFrame` that is created from the `checklist_df` function can also be edited within a Julia program using functions from the `DataFrames` package:

```julia
using PRISMA: checklist_df
using DataFrames: DataFrame

clist_template::DataFrame = checklist_df()

println(clist_template)

clist_template[3, "Location where item is reported"] = "Sysemtatic review is in the title."
clist_template[5, "Location where item is reported"] = "The completed abastract is located on page one."

println(clist_template)
```

The `DataFrame` from a `Checklist` can still be edited after the paper is read by access the `df` field from the `Checklist` type:

```julia
using PRISMA: Checklist, checklist
using DataFrames: DataFrame

clist::Checklist = checklist("manuscript.pdf")

clist_df::DataFrame = clist.df

clist_df[3, "Location where item is reported"] = "Sysemtatic review is in the title."
clist_df[5, "Location where item is reported"] = "The completed abastract is located on page one."

println(clist_df)
```

## :books: References

> Bezanson, J., Edelman, A., Karpinski, S., & Shah, V. B. (2017). Julia: A fresh approach to numerical computing. SIAM Review, 59(1), 65–98. https://doi.org/10.1137/141000671

> Bouchet-Valat, M., & Kamiński, B. (2023). DataFrames.jl: Flexible and Fast Tabular Data in Julia. Journal of Statistical Software, 107(4), 1–32. https://doi.org/10.18637/jss.v107.i04

> Page M J, McKenzie J E, Bossuyt P M, Boutron I, Hoffmann T C, Mulrow C D et al. (2021). The PRISMA 2020 statement: An updated guideline for reporting systematic reviews. Systematic Reviews, 10(1), 89. https://doi.org/10.1186/s13643-021-01626-4