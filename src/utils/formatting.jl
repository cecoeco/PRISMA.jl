using DataFrames

function format_number(number)
    string::String = Base.string(number)
    formatted_string::String = Base.replace(str, r"(?<=[0-9])(?=(?:[0-9]{3})+(?![0-9]))" => ",")
    return formatted_string
end

function format_dataframe(df::DataFrame)
    formatted_df::DataFrame = DataFrames.DataFrame()
    for col in Base.names(df)
        formatted_df[!, col] = Base.map(format_number, df[!, col])
    end
    return formatted_df
end