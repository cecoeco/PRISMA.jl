"""
    format_number(number)

Formats a number to a string with commas in the thousands.

# Arguments
- `number`: The number to format.

# Returns
- `formatted_string`: The formatted string.
"""
function format_number(number)
    string::String = Base.string(number)
    formatted_string::String = Base.replace(string, r"(?<=[0-9])(?=(?:[0-9]{3})+(?![0-9]))" => ",")
    return formatted_string
end