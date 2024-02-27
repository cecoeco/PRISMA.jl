using XLSX

include("flow_diagram_df.jl")

function flow_diagram_xlsx(save_location::String=pwd(), filename::String="flow_diagram")
    df = flow_diagram_df()
    XLSX.writetable("$save_location/$filename.xlsx", df)
    Base.println("DataFrame successfully written to $save_location/$filename.xlsx")
    return "$save_location/$filename.xlsx"
end
