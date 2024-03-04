"""
    flow_diagram_xlsx(save_location::String=pwd(), filename::String="flow_diagram", sheetname::String="flow_diagram")

Writes the flow diagram dataframe to an XLSX file.

# Arguments
- `save_location::String`: The directory to save the XLSX file.
- `filename::String`: The name of the XLSX file.
- `sheetname::String`: The name of the sheet in the XLSX file.

# Returns
- `String`: The path to the XLSX file.
"""
function flow_diagram_xlsx(save_location::String=pwd(), filename::String="flow_diagram", sheetname::String="flow_diagram")
    df::DataFrame = flow_diagram_df()
    path::String = Base.joinpath(save_location, "$filename.xlsx")
    XLSX.writetable(path, sheetname => df)
    Base.println("DataFrame successfully written to" * path * " on sheet '$sheetname'")
    return path
end