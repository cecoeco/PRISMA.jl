using CSV

include("flow_diagram_df.jl")

function flow_diagram_csv(save_location::String=Base.pwd(), filename::String="flow_diagram")
    df = flow_diagram_df()
    CSV.write("$save_location/$filename.csv", df)
    Base.println("DataFrame successfully written to $save_location/$filename.csv")
    return "$save_location/$filename.csv" 
end
