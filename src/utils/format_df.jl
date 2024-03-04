"""
    format_df(df::DataFrame)

Formats a dataframe to a string with commas in the thousands.

# Arguments
- `df`: The dataframe to format.

# Returns
- `formatted_df`: The formatted dataframe.
"""
function format_df(df::DataFrame)
    formatted_df::DataFrame = DataFrames.DataFrame()
    for col in Base.names(df)
        formatted_df[!, col] = Base.map(format_number, df[!, col])
    end
    return formatted_df
end