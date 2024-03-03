using JSON3
using DataStructures

include("checklist_df.jl")

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