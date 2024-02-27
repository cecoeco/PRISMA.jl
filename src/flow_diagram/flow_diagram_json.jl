using JSON3

include("flow_diagram_df.jl")

function flow_diagram_json(save_location::String=Base.pwd(), filename::String="flow_diagram")
    df = flow_diagram_df()
    flow_diagram_dictionary = Base.Dict{String,Any}()
    for col in Base.names(df)
        flow_diagram_dictionary[col] = df[!, col]
    end
    JSON3.write("$save_location/$filename.json", flow_diagram_dictionary)
    Base.println("DataFrame successfully written to $save_location/$filename.json")
    return "$save_location/$filename.json"
end