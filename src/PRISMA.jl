"""
# PRISMA.jl

Julia package for generating checklists and flow diagrams based on [the 2020 **P**referred **R**eporting **I**tems for **S**ystematic **R**eviews and **M**eta-**A**nalyses (PRISMA) statement (Page et al., 2021).](https://doi.org/10.1186/s13643-021-01626-4)

## Functions

- `checklist_df`: returns an empty PRISMA checklist as the type `DataFrame`
- `checklist_template`: returns a template PRISMA checklist as a `.csv` file
- `checklist_read`: reads the checklist data as a `DataFrame` from a data file
- `checklist`: returns a completed PRISMA checklist as the type `Checklist`
- `checklist_save`: saves a `Checklist` as a `.csv` file

- `flow_diagram_df`: returns the `DataFrame` that is used to create the flow diagram
- `flow_diagram_template`: returns a template PRISMA flow diagram data as a `.csv` file
- `flow_diagram_read`: reads the flow diagram data as a `DataFrame` from a data file
- `flow_diagram`: returns a PRISMA flow diagram as the type `FlowDiagram`
- `flow_diagram_save`: saves a `FlowDiagram` to file formats supported by `Graphviz`

## Types

- `Checklist`: includes a completed checklist and paper metadata
- `FlowDiagram`: the PRISMA flow diagram represented as Graphviz's DOT language

## Reexports

- `DataFrames.DataFrame`: both `flow_diagram_df` and `checklist_df` return a `DataFrame`
- `Base.display`: `PRISMA` adds a method for displaying the `FlowDiagram` in the plot panel
- `Base.show`: `PRISMA` adds new methods for printing the `Checklist` and `FlowDiagram` types

"""
module PRISMA

using CSV, DataFrames, Graphviz_jll, OrderedCollections, Poppler_jll, Transformers

import Base.Multimedia.display, Base.show

export
    # re-exports
    DataFrame, display, show,

    # checklist.jl
    checklist_df, checklist_template,
    checklist_read, checklist,
    Checklist, checklist_save,

    # flow_diagram.jl
    flow_diagram_df, flow_diagram_template,
    flow_diagram_read, flow_diagram,
    FlowDiagram, flow_diagram_save

for file in [
    "checklist_docstrings.jl",
    "checklist.jl",
    "flow_diagram_docstrings.jl",
    "flow_diagram.jl",
]
    include(file)
end

end # module