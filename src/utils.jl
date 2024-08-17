function save_dataframe(
    fn::AbstractString,
    df::DataFrame,
    sheetname::AbstractString;
    kwargs...)::String

    ext::String = splitext(fn)[2]
    if ext == ".csv"
        CSV.write(fn, df; kwargs...)
    elseif ext == ".xlsx"
        XLSX.writetable(fn, sheetname => df; kwargs...)
    elseif ext == ".html"
        HTMLTables.write(fn, df; kwargs...)
    elseif ext == ".json"
        JSON3.write(fn, JSONTables.objecttable(df); kwargs...)
    else
        throw(ArgumentError("unsupported file extension: $ext"))
    end

    return fn
end

function check_overwrite(fn::AbstractString, overwrite::Bool)
    if isfile(fn) && !overwrite
        throw(ArgumentError("file $fn already exists"))
    end
end
