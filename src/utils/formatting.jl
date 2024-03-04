"""
    format_number(number)

Formats a number to a string with commas in the thousands.

# Arguments
- `number`: The number to format.

# Returns
- `formatted_string`: The formatted string.

# Examples
```jldoctest
julia> format_number(1000000)
"1,000,000"
```
"""
function format_number(number)
    string::String = Base.string(number)
    formatted_string::String = Base.replace(str, r"(?<=[0-9])(?=(?:[0-9]{3})+(?![0-9]))" => ",")
    return formatted_string
end
"""
    format_dataframe(df::DataFrame)

Formats a dataframe to a string with commas in the thousands.

# Arguments
- `df`: The dataframe to format.

# Returns
- `formatted_df`: The formatted dataframe.

# Examples
```jldoctest
julia> format_dataframe(DataFrame(x=[1000000, 2000000]))
2×1 DataFrame
 Row │ x
     │ String
─────┼────────
   1 │ 1,000,000
   2 │ 2,000,000
```
"""
function format_dataframe(df::DataFrame)
    formatted_df::DataFrame = DataFrames.DataFrame()
    for col in Base.names(df)
        formatted_df[!, col] = Base.map(format_number, df[!, col])
    end
    return formatted_df
end