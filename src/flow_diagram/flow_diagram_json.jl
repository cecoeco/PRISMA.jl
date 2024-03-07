"""
    flow_diagram_json(; save_location::String=Base.pwd(), filename::String="flow_diagram")

Writes the flow diagram dataframe to a JSON file.

# Arguments
- `save_location::String`: The directory to save the JSON file.
- `filename::String`: The name of the JSON file.

# Returns
- `String`: The path to the JSON file.
"""
function flow_diagram_json(; save_location::String=Base.pwd(), filename::String="flow_diagram")
    df::DataFrame = flow_diagram_df()
    path::String = Base.joinpath(save_location, "$filename.json")
    dictionary::OrderedDict = DataStructures.OrderedDict(
        "node_id" => df[!, "node_id"],
        "node_tooltip" => df[!, "node_tooltip"],
        "node_text" => df[!, "node_text"],
        "num" => df[!, "num"]
    )
    JSON3.write(path, dictionary)
    Base.println("DataFrame successfully written to" * path)
    return path
end