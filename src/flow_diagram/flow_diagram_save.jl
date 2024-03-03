using Makie

include("flow_diagram.jl")

function flow_diagram_save(
    figure::Makie.Figure=flow_diagram(),
    name::String="figure",
    save_location::String=Base.pwd(),
    save_format::String="svg"
)
    supported_formats = ["png", "jpg", "svg", "pdf", "html"]
    if !(save_format in supported_formats)
        Base.error("Unsupported save format: $save_format. Supported formats are: $(join(supported_formats, ", "))")
    end
    Makie.save(Base.joinpath(save_location, "$name.$save_format"), figure)
    Base.println("Figure successfully saved to $(Base.joinpath(save_location, "$name.$save_format"))")
    return Base.joinpath(save_location, "$name.$save_format")
end