"""
    percentage(percent::Union{String, Number})

Symbolic representation of a percentage.

# Arguments
- `percent::Union{String, Number}`: The percentage.

# Returns
- `percent::Number`: The percentage.
"""
function percentage(percent::Union{String,Number})
    if Base.typeof(percent) == String
        if Base.occursin("%", percent)
            percent = Base.parse(Float64, Base.chop(percent, tail=1)) / 100
        else
            percent = Base.parse(Float64, percent)
        end
    end
    return percent
end
