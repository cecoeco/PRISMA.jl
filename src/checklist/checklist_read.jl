using DataFrames
using CSV
using XLSX
using JSON3

function checklist_read(file::String="")
    ext = Base.lowercase(Base.splitext(file)[2])

    if ext == ".csv"
        df = CSV.read(file, DataFrame)
        Base.println("DataFrame successfully read from $file")
    elseif ext == ".xlsx"
        df = XLSX.readdata(file, XLSX.sheetnames(file)[1]) |> DataFrame
        Base.println("DataFrame successfully read from $file")
    elseif ext == ".json"
        df = JSON3.read(file) |> DataFrame
        Base.println("DataFrame successfully read from $file")
    else
        Base.throw(Base.ArgumentError("Unsupported file format: $ext"))
    end

    return df::DataFrame
end
