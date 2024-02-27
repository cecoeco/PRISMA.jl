using CSV

include("checklist_df.jl")

function checklist_csv(save_location::String=Base.pwd(), filename::String="checklist")
    df = checklist_df()
    CSV.write("$save_location/$filename.csv", df)
    Base.println("DataFrame successfully written to $save_location/$filename.csv")
    return "$save_location/$filename.csv" 
end
