using XLSX

include("checklist_df.jl")

function checklist_xlsx(save_location::String=Base.pwd(), filename::String="checklist", sheetname::String="checklist")
    df::DataFrame = checklist_df()
    path::String = Base.joinpath(save_location, "$filename.xlsx")
    XLSX.writetable(path, sheetname => df)
    Base.println("DataFrame successfully written to" * path * " on sheet '$sheetname'")
    return path
end