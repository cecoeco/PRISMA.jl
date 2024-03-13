"""
    flow_diagram_csv(; save_location::String=Base.pwd(), filename::String="flow_diagram")

Writes the flow diagram dataframe to a CSV file.

# Arguments
- `save_location::String`: The directory to save the CSV file. Default is the current directory.
- `filename::String`: The name of the CSV file. Default is "flow_diagram".
- `success_message::Bool`: Whether to print a success message. Default is true.

# Returns
- `String`: The path to the CSV file.
"""
function flow_diagram_csv(; 
    save_location::String=Base.pwd(), 
    filename::String="flow_diagram", 
    success_message::Bool=true
)
    df::DataFrame = flow_diagram_df()
    path::String = Base.joinpath(save_location, "$filename.csv")
    CSV.write(path, df)
    if success_message == true
        Base.println("DataFrame successfully written to $path")
    end
    return path
end