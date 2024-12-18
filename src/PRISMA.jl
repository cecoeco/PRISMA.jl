"""
# PRISMA.jl

Julia package for generating checklists and flow diagrams based on [the 2020 **P**referred **R**eporting **I**tems for **S**ystematic **R**eviews and **M**eta-**A**nalyses (PRISMA) statement (Page et al., 2021).](https://doi.org/10.1186/s13643-021-01626-4)

## New Functions and Types:

For working with PRISMA checklists:

- `checklist_dataframe` - returns an empty PRISMA checklist as the type `DataFrame`
- `checklist_template` - returns an empty PRISMA checklist as comma-separated values
- `checklist_read` - reads the checklist data as a `DataFrame` from comma-separated values
- `checklist` - takes a PDF and returns a completed PRISMA checklist as the type `Checklist`
- `checklist_save` - saves a `Checklist` as comma-separated values
- `Checklist` - includes a completed checklist and paper metadata

For working with PRISMA flow diagrams:

- `flow_diagram_dataframe` - returns the template PRISMA flow diagram data as a `DataFrame`
- `flow_diagram_template` - returns the template PRISMA flow diagram data as comma-separated values
- `flow_diagram_read` - reads the flow diagram data as a `DataFrame` from comma-separated values
- `flow_diagram` - returns a PRISMA flow diagram as the type `FlowDiagram`
- `flow_diagram_save` - saves a `FlowDiagram` using Graphviz
- `FlowDiagram` - the flow diagram type that can be displayed in the plot panel or saved

## Reexports

- `OrderedCollections.OrderedDict` - `Checklist.metadata` returns an `OrderedDict`
- `DataFrames.DataFrame` - both `flow_diagram_dataframe` and `checklist_dataframe` return a `DataFrame`
- `Base.display` - `PRISMA` adds a method for displaying the `FlowDiagram` in the plot panel
- `Base.show` - `PRISMA` adds new methods for printing the `Checklist` and `FlowDiagram` types

"""
module PRISMA

using CSV
using DataFrames
using Graphviz_jll
using OrderedCollections
using Poppler_jll

import Base.Multimedia.display
import Base.show

export
    # re-exports
    OrderedDict,
    DataFrame,
    display,
    show,
    # checklist.jl
    checklist_dataframe,
    checklist_template,
    checklist_read,
    checklist,
    Checklist,
    checklist_save,
    # flow_diagram.jl
    flow_diagram_dataframe,
    flow_diagram_template,
    flow_diagram_read,
    flow_diagram,
    FlowDiagram,
    flow_diagram_save

include("checklist.jl")
include("flow_diagram.jl")

end # module
