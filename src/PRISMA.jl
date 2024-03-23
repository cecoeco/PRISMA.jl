module PRISMA

using CSV
using DataFrames
using DataStructures
using JSON3
using NodeJS
using XLSX

include("checklist.jl")
include("flow_diagram.jl")
include("utils.jl")

"""
    plot(figure)

Displays the checklist or flow diagram figure in a new window.
"""
function plot(figure)
    if Base.typeof(figure) == PRISMA.Checklist
        PRISMA.checklist_plot(figure)
    elseif Base.typeof(figure) == PRISMA.FlowDiagram
        PRISMA.flow_diagram_plot(figure)
    else
        Base.error("Unsupported plot type: $(Base.typeof(figure)). Supported types are: PRISMA.Checklist, PRISMA.FlowDiagram")
    end
end

"""
    save(; figure, name::String, save_location::String=Base.pwd(), save_format::String)

Saves the checklist or flow diagram figure.

# Arguments
- `figure`: The checklist or flow diagram figure.
- `name::String`: The name of the figure.
- `save_location::String`: The directory to save the figure.
- `save_format::String`: The format to save the figure.

# Returns
- `String`: The path to the saved figure.
"""
function save(; 
    figure, 
    name::String, 
    save_location::String=Base.pwd(), 
    save_format::String
)
    if Base.typeof(figure) == PRISMA.Checklist
        PRISMA.checklist_save(
            html_table=figure, 
            name=name, 
            save_location=save_location, 
            save_format=save_format
        )
    elseif Base.typeof(figure) == PRISMA.FlowDiagram
        PRISMA.flow_diagram_save(
            figure=figure, 
            name=name,
            save_location=save_location, 
            save_format=save_format
        )
    else
        Base.error("Unsupported save type: $(Base.typeof(figure)). Supported types are: PRISMA.Checklist, PRISMA.FlowDiagram")
    end
    path = Base.joinpath(save_location, "$name.$save_format")
    return path
end

export checklist_df
export checklist_csv
export checklist_json
export checklist_xlsx
export checklist_read
export checklist
export checklist_plot
export checklist_save

export flow_diagram_df
export flow_diagram_csv
export flow_diagram_json
export flow_diagram_xlsx
export flow_diagram_read
export flow_diagram
export flow_diagram_plot
export flow_diagram_save

export plot
export save

export format_number
export format_df

export percentage
export percentages

export open
export docs
export statement
export app

end