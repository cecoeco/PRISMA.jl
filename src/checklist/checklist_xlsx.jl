"""
    checklist_xlsx(save_location::String=Base.pwd(), filename::String="checklist", sheetname::String="checklist")

Writes the checklist dataframe to an XLSX file.

# Arguments
- `save_location::String`: The directory to save the XLSX file.
- `filename::String`: The name of the XLSX file.
- `sheetname::String`: The name of the sheet in the XLSX file.

# Returns
- `String`: The path to the XLSX file.
"""
function checklist_xlsx(save_location::String=Base.pwd(), filename::String="checklist", sheetname::String="checklist")
    df::DataFrame = checklist_df()
    path::String = Base.joinpath(save_location, "$filename.xlsx")
    XLSX.writetable(path, sheetname => df)
    Base.println("DataFrame successfully written to" * path * " on sheet '$sheetname'")
    return path
end