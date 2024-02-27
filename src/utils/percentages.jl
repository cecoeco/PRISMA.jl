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

function percentages(percents::Vector{Union{String, Number}})
    return [percentage(percent) for percent in percents]
end