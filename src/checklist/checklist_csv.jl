using CSV

include("checklist_df.jl")

function checklist_csv(save_location::String=Base.pwd(), filename::String="checklist")
    df::DataFrame = checklist_df()
    path::String = Base.joinpath(save_location, "$filename.csv")
    CSV.write(path, df)
    Base.println("DataFrame successfully written to" * path)
    return path
end