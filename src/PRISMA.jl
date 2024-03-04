"""
Generate checklists and flow diagrams based on the Preferred Reporting Items for Systematic Reviews and Meta-Analyses (PRISMA) statement.

Checklist:
- `PRISMA.checklist_df`: Returns a `DataFrame` of the checklist.
- `PRISMA.checklist_csv`: Writes the checklist to a CSV file.
- `PRISMA.checklist_json`: Writes the checklist to a JSON file.
- `PRISMA.checklist_xlsx`: Writes the checklist to an Excel file.
- `PRISMA.checklist_read`: Reads the checklist from a CSV, JSON, or Excel file.

Flow Diagram:
- `PRISMA.flow_diagram_df`: Returns a `DataFrame` of the flow diagram.
- `PRISMA.flow_diagram_csv`: Writes the flow diagram to a CSV file.
- `PRISMA.flow_diagram_json`: Writes the flow diagram to a JSON file.
- `PRISMA.flow_diagram_xlsx`: Writes the flow diagram to an Excel file.
- `PRISMA.flow_diagram_read`: Reads the flow diagram from a CSV, JSON, or Excel file.
- `PRISMA.flow_diagram`: Generates the flow diagram.
- `PRISMA.flow_diagram_save`: Saves the flow diagram to an image file.

Utils:
- `PRISMA.format_number`: Formats a number of to a string with commas in the thousands.
- `PRISMA.format_df`: Formats numbers in a `DataFrame` to strings with commas in the thousands.
- `PRISMA.open`: Open the web application for PRISMA.jl.
- `PRISMA.percentage`: Symbolic representation of a percentage.
- `PRISMA.percentages`: Symbolic representation of a vector of percentages.

"""
module PRISMA

using CSV
using CairoMakie
using DataFrames
using DataStructures
using GLMakie
using JSON3
using Makie
using RPRMakie
using WGLMakie
using XLSX

include("checklist/checklist_df.jl")
include("checklist/checklist_csv.jl")
include("checklist/checklist_json.jl")
include("checklist/checklist_xlsx.jl")
include("checklist/checklist_read.jl")

include("flow_diagram/flow_diagram_df.jl")
include("flow_diagram/flow_diagram_csv.jl")
include("flow_diagram/flow_diagram_json.jl")
include("flow_diagram/flow_diagram_xlsx.jl")
include("flow_diagram/flow_diagram_read.jl")
include("flow_diagram/flow_diagram.jl")
include("flow_diagram/flow_diagram_save.jl")

include("utils/format_number.jl")
include("utils/format_df.jl")
include("utils/open.jl")
include("utils/percentage.jl")
include("utils/percentages.jl")

export checklist_df
export checklist_csv
export checklist_json
export checklist_xlsx
export checklist_read

export flow_diagram_df
export flow_diagram_csv
export flow_diagram_json
export flow_diagram_xlsx
export flow_diagram_read
export flow_diagram
export flow_diagram_save

export format_number
export format_df
export open
export percentage
export percentages

end