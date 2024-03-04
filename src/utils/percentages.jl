"""
    percentage(percent::Union{String, Number})

Symbolic representation of a percentage.

# Arguments
- `percent::Union{String, Number}`: The percentage.

# Returns
- `percent::Number`: The percentage.

# Examples
```jldoctest
julia> percentage("10%")
0.1
```
"""
function percentage(percent::Union{String, Number})
    if Base.typeof(percent) == String
        if Base.occursin("%", percent)
            percent = Base.parse(Float64, Base.chop(percent, tail=1)) / 100
        else
            percent = Base.parse(Float64, percent)
        end
    end
    return percent
end
"""
    percentages(percents::Vector{Union{String, Number}})

Symbolic representation of a vector of percentages.

# Arguments
- `percents::Vector{Union{String, Number}}`: The vector of percentages.

# Returns
- `percent::Vector{Number}`: The vector of percentages.

# Examples
```jldoctest
julia> percentages(["10%", "20%"])
[0.1, 0.2]
```
"""
function percentages(percents::Vector{Union{String, Number}})
    return [percentage(percent) for percent in percents]
end