"""
# PRISMA.jl

Julia package for generating checklists and flow diagrams based on [the 2020 **P**referred **R**eporting **I**tems for **S**ystematic **R**eviews and **M**eta-**A**nalyses (PRISMA) statement (Page et al., 2021).](https://doi.org/10.1186/s13643-021-01626-4)

## Functions

- `checklist_df`: returns an empty PRISMA checklist as the type `DataFrame`
- `checklist`: returns a completed PRISMA checklist as the type `Checklist`
- `checklist_read`: reads the checklist data as a `DataFrame` from a data file
- `checklist_save`: saves a `Checklist` as either a `.csv`, `.xlsx`, `.html`, or `.json` file

- `flow_diagram_df`: returns the `DataFrame` that is used to create the flow diagram
- `flow_diagram`: returns a PRISMA flow diagram as the type `FlowDiagram`
- `flow_diagram_read`: reads the flow diagram data as a `DataFrame` from a data file
- `flow_diagram_save`: saves a `FlowDiagram` to file formats supported by `Graphviz`

## Types

- `Checklist`: includes a completed checklist and paper metadata
- `FlowDiagram`: the PRISMA flow diagram represented as Graphviz's DOT language

## Reexports

- `DataFrames.DataFrame`: both `flow_diagram_df` and `checklist_df` return a `DataFrame`
- `DataStructures.LittleDict`: the metadata field of the `Checklist` type is a small ordered dictionary
- `Base.display`: `PRISMA` adds a method for displaying the `FlowDiagram` type
- `Base.show`: `PRISMA` adds new methods for showing the `Checklist` and `FlowDiagram` types

"""
module PRISMA

using CSV: CSV
using DataFrames: DataFrame, GroupedDataFrame, rename!, nrow, groupby, push!
using DataStructures: LittleDict
using Graphviz_jll: neato
using HTMLTables: HTMLTables
using JSON3: JSON3
using JSONTables: JSONTables
using LinearAlgebra: norm, dot
using Poppler_jll: pdfinfo, pdftotext
using Statistics: mean
using TidierStrings: str_wrap
using Transformers: encode, @hgf_str
using XLSX: XLSX

export
    # re-exports
    DataFrame, LittleDict, display, show,
    # checklist.jl
    checklist_df, checklist_read, checklist, Checklist, checklist_save,
    # flow_diagram.jl
    flow_diagram_df, flow_diagram_read, flow_diagram, FlowDiagram, flow_diagram_save

include("docstrings.jl")
include("utils.jl")
include("checklist.jl")
include("flow_diagram.jl")
include("show.jl")

end