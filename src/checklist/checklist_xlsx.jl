using XLSX

include("checklist_df.jl")

function checklist_xlsx(save_location::String=Base.pwd(), filename::String="checklist")
    df = checklist_df()
    XLSX.writetable("$save_location/$filename.xlsx", df)
    Base.println("DataFrame successfully written to $save_location/$filename.xlsx")
    return "$save_location/$filename.xlsx"
end
