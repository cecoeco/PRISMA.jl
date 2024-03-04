using JSON3
"""
    checklist_json(save_location::String=Base.pwd(), filename::String="checklist")

Writes the checklist dataframe to a JSON file.

# Arguments
- `save_location::String`: The directory to save the JSON file.
- `filename::String`: The name of the JSON file.

# Returns
- `String`: The path to the JSON file.

# Examples
```jldoctest
julia> checklist_json()
"checklist.json"
```
"""
function checklist_json(save_location::String=Base.pwd(), filename::String="checklist")
    df::DataFrame = checklist_df()
    path::String = Base.joinpath(save_location, "$filename.json")
    dictionary::OrderedDict = DataStructures.OrderedDict(
        "Section and Topic" => df[!, "Section and Topic"],
        "Item #" => df[!, "Item #"],
        "Checklist Item" => df[!, "Checklist Item"],
        "Location where item is reported" => df[!, "Location where item is reported"]
    )
    JSON3.write(path, dictionary)
    Base.println("DataFrame successfully written to" * path)
    return path
end