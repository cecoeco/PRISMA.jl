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
        return throw(ArgumentError("unsupported file extension: $ext"))
    end

    return fn
end

function check_overwrite(fn::AbstractString, overwrite::Bool)::Nothing
    if isfile(fn) && !overwrite
        return throw(ArgumentError("file $fn already exists"))
    end
end

function read_as_dataframe(
    fn::AbstractString;
    sheetname::AbstractString="",
    json_type::T,
    kwargs...)::DataFrame

    ext::String = splitext(fn)[2]
    if ext == ".csv"
        return CSV.read(fn, DataFrame; kwargs...)
    elseif ext == ".xlsx"
        return DataFrame(XLSX.readtable(fn, sheetname; kwargs...))
    elseif ext == ".html"
        return HTMLTables.read(fn, DataFrame; kwargs...)
    elseif ext == ".json"
        return JSONTables.jsontable(JSON3.read(fn, json_type; kwargs...))
    else
        return throw(ArgumentError("unsupported file extension: $ext"))
    end
end