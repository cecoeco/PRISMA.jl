using XLSX

include("flow_diagram_df.jl")

function flow_diagram_xlsx(save_location::String=pwd(), filename::String="flow_diagram", sheetname::String="flow_diagram")
    df::DataFrame = flow_diagram_df()
    path::String = Base.joinpath(save_location, "$filename.xlsx")
    XLSX.writetable(path, sheetname => df)
    Base.println("DataFrame successfully written to" * path * " on sheet '$sheetname'")
    return path
end