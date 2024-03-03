using CSV

include("flow_diagram_df.jl")

function flow_diagram_csv(save_location::String=Base.pwd(), filename::String="flow_diagram")
    df::DataFrame = flow_diagram_df()
    path::String = Base.joinpath(save_location, "$filename.csv")
    CSV.write(path, df)
    Base.println("DataFrame successfully written to" * path)
    return path
end