using DataFrames
using CSV
using XLSX
using JSON3

function checklist_read(file="", excel_sheetname::Union{Nothing,String}=nothing)
    ext = Base.lowercase(Base.splitext(file)[2])
    if ext == ".csv"
        df = CSV.read(file, DataFrame)
        Base.println("DataFrame successfully read from $file")
    elseif ext == ".xlsx"
        if isnothing(excel_sheetname)
            df = XLSX.readtable(file, "checklist") |> DataFrame
        else
            df = XLSX.readtable(file, excel_sheetname) |> DataFrame
        end
        Base.println("DataFrame successfully read from $file")
    elseif ext == ".json"
        df = JSON3.read(file) |> DataFrame
        Base.println("DataFrame successfully read from $file")
    else
        Base.throw(Base.ArgumentError("Unsupported file format: $ext"))
    end
    return df
end