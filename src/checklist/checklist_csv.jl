"""
    checklist_csv(save_location::String=Base.pwd(), filename::String="checklist")

Writes the checklist dataframe to a CSV file.

# Arguments
- `save_location::String`: The directory to save the CSV file.
- `filename::String`: The name of the CSV file.

# Returns
- `String`: The path to the CSV file.
"""
function checklist_csv(save_location::String=Base.pwd(), filename::String="checklist")
    df::DataFrame = checklist_df()
    path::String = Base.joinpath(save_location, "$filename.csv")
    CSV.write(path, df)
    Base.println("DataFrame successfully written to" * path)
    return path
end