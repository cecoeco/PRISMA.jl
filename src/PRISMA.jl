"""
# PRISMA.jl

Julia package for generating checklists and flow diagrams based on the [2020 **P**referred **R**eporting **I**tems for **S**ystematic **R**eviews and **M**eta-**A**nalyses (PRISMA) statement (Page et al., 2021).](https://doi.org/10.1186/s13643-021-01626-4)

## Functions

- `checklist_df`: returns an empty PRISMA checklist as the type `DataFrame`
- `checklist`: returns a completed PRISMA checklist as the type `Checklist`
- `flow_diagram_df`: returns the `DataFrame` that is used to create the flow diagram
- `flow_diagram`: returns a completed PRISMA flow diagram as the type `FlowDiagram`
- `flow_diagram_save`: saves a `FlowDiagram` to any file format supported by `Graphviz_jll`

## Types

- `Checklist`: includes a completed checklist and paper metadata
- `FlowDiagram`: the PRISMA flow diagram represented as Graphviz's DOT language

"""
module PRISMA

using DataFrames: DataFrame, GroupedDataFrame, rename!, nrow, groupby, push!
using DataStructures: LittleDict
using Graphviz_jll: neato
using LinearAlgebra: norm, dot
using Poppler_jll: pdfinfo, pdftotext
using Statistics: mean
using Transformers: encode, @hgf_str

export checklist_df, checklist, Checklist
export flow_diagram_df, flow_diagram, FlowDiagram, flow_diagram_save

include("checklist.jl")
include("flow_diagram.jl")

end