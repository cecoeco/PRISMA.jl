using JSON3

include("checklist_df.jl")

function checklist_json(save_location::String=Base.pwd(), filename::String="checklist")
    df = checklist_df()
    checklist_dictionary = Base.Dict{String,Any}()
    for col in Base.names(df)
        checklist_dictionary[col] = df[!, col]
    end
    JSON3.write("$save_location/$filename.json", checklist_dictionary)
    Base.println("DataFrame successfully written to $save_location/$filename.json")
    return "$save_location/$filename.json"
end