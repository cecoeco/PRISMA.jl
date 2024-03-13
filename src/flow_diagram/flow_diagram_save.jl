"""
    flow_diagram_save(; figure::Makie.Figure=flow_diagram(), name::String="figure", save_location::String=Base.pwd(), save_format::String="svg")

Saves the flow diagram figure.

# Arguments
- `figure::Makie.Figure`: The flow diagram figure.
- `name::String`: The name of the figure.
- `save_location::String`: The directory to save the figure.
- `save_format::String`: The format to save the figure as.

# Returns
- `String`: The path to the saved figure.
"""
function flow_diagram_save(;
    figure=flow_diagram(),
    name::String="figure",
    save_location::String=Base.pwd(),
    save_format::String="svg"
)
    if save_format == "jpeg" return save_format = "jpg" end
    supported_formats = ["png", "jpg", "svg", "pdf", "html"]
    if !(save_format in supported_formats) 
        return Base.error("Unsupported save format: $save_format. Supported formats are: $(Base.join(supported_formats, ", "))") 
    end
    path = Base.joinpath(save_location, "$name.$save_format")
    if Base.typeof(figure) == Makie.Figure 
        return Makie.save(path, figure) 
    else 
        return Base.save(path, figure) 
    end
    Base.println("Figure successfully saved to $(path)")
    return path
end