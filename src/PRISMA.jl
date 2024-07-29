"""
# PRISMA.jl

Julia package for generating checklists and flow diagrams based on the [the **P**referred **R**eporting **I**tems for **S**ystematic **R**eviews and **M**eta-**A**nalyses (PRISMA) statement (Page et al., 2021).](https://doi.org/10.1186/s13643-021-01626-4)

## Functions

- `checklist_df`: returns an imcomplete PRISMA checklist as a `DataFrame`
- `checklist`: returns a completed PRISMA checklist as a `Checklist`
- `flow_diagram_df`: returns an imcomplete PRISMA flowchart as a `DataFrame`
- `flow_diagram`: returns a completed PRISMA flowchart as a `FlowDiagram`
- `flow_diagram_save`: saves a completed PRISMA flowchart as a `FlowDiagram`
- `Base.show`: uses an `IO` to print a `FlowDiagram`
- `Base.Multimedia.display`: displays or plots a `FlowDiagram`

## Types

- `Checklist`: includes a completed checklist and paper metadata
- `FlowDiagram`: the PRISMA flow diagram represented as Graphviz's DOT language

"""
module PRISMA

using DataFrames: DataFrame, rename!, nrow, groupby
using DataStructures: LittleDict
using Graphviz_jll: neato
using LinearAlgebra: norm, dot
using Poppler_jll: pdfinfo, pdftotext
using Statistics: mean
using Transformers: encode, @hgf_str

import Base.show, Base.Multimedia.display

export checklist_df, checklist, Checklist
export flow_diagram_df, flow_diagram, FlowDiagram, flow_diagram_save
export show, display

include("checklist.jl")
include("flow_diagram.jl")

end