"""
    percentages(percents::Vector{Union{String, Number}})

Symbolic representation of a vector of percentages.

# Arguments
- `percents::Vector{Union{String, Number}}`: The vector of percentages.

# Returns
- `percents::Vector{Number}`: The vector of percentages.
"""
function percentages(percents::Vector{Union{String,Number}})
    percents = [percentage(percent) for percent in percents]
    return percents
end