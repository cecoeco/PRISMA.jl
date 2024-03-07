"""
    flow_diagram_read(; file::String="", excel_sheetname::Union{Nothing,String}=nothing, format_numbers::Bool=false)

Reads the flow diagram dataframe from a CSV, XLSX, or JSON file.

# Arguments
- `file::String`: The path to the CSV, XLSX, or JSON file.
- `excel_sheetname::Union{Nothing,String}`: The name of the sheet in the XLSX file.
- `format_numbers::Bool`: Whether to format numbers in the dataframe.

# Returns
- `DataFrame`: The flow diagram dataframe.
"""
function flow_diagram_read(; file::String="", excel_sheetname::Union{Nothing,String}=nothing, format_numbers::Bool=false)
    ext::String = Base.lowercase(Base.splitext(file)[2])
    if ext == ".csv"
        df = CSV.read(file, DataFrame)
        Base.println("DataFrame successfully read from $file")
    elseif ext == ".xlsx"
        if Base.isnothing(excel_sheetname)
            df = XLSX.readtable(file, "flow_diagram") |> DataFrame
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
    if format_numbers == true
        df = format_df(df)
    end
    return df
end