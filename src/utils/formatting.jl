using DataFrames

function format_number(number)
    str = Base.string(number)
    return Base.replace(str, r"(?<=[0-9])(?=(?:[0-9]{3})+(?![0-9]))" => ",")
end

function format_dataframe(df::DataFrame)
    formatted_df = DataFrames.DataFrame()
    for col in Base.names(df)
        formatted_df[!, col] = Base.map(format_number, df[!, col])
    end
    return formatted_df
end