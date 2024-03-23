"""
    open(os::Union{String, Nothing}=nothing, resources::Bool=false)

Open the PRISMA web application.

# Arguments
- `os::Union{String, Nothing}=nothing`: The operating system to use. If `nothing`, the default value is used.
- `resources::Bool=false`: Whether to open the resources page.
"""
function open(; os::Union{String, Nothing}=nothing, resources::Bool=false)
    app_url::String = "https://prismajl.onrender.com"
    documentation_url::String = "https://cecoeco.github.io/PRISMA.jl"
    statement_url::String = "https://prisma-statement.org"

    if os === nothing
        if Base.Sys.isapple() == true return Base.run(`open $app_url`)
        elseif Base.Sys.iswindows() == true return Base.run(`start $app_url`)
        elseif Base.Sys.islinux() == true return Base.run(`xdg-open $app_url`)
        end
    else
        if os == "macos" return Base.run(`open $app_url`)
        elseif os == "windows" return Base.run(`start $app_url`)
        elseif os == "linux" return Base.run(`xdg-open $app_url`)
        else return Base.error("Unsupported operating system: $os")
        end
    end

    if resources == true
        if os === nothing
            if Base.Sys.isapple() == true return Base.run(`open $statement_url`); Base.run(`open $documentation_url`)
            elseif Base.Sys.iswindows() == true return Base.run(`start $statement_urle`); Base.run(`start $documentation_url`)
            elseif Base.Sys.islinux() == true return Base.run(`xdg-open $statement_url`); Base.run(`xdg-open $documentation_url`)
            end
        else
            if os == "macos" return Base.run(`open $resource`); Base.run(`open $documentation`)
            elseif os == "windows" return Base.run(`start $resource`); Base.run(`start $documentation`)
            elseif os == "linux" return Base.run(`xdg-open $resource`); Base.run(`xdg-open $documentation`)
            else return Base.error("Unsupported operating system: $os")
            end
        end
    end
end

"""
    app(; os::Union{String, Nothing}=nothing)

Open the PRISMA web application.

# Arguments
- `os::Union{String, Nothing}=nothing`: The operating system to use. If `nothing`, the default value is used.
"""
function app(; os::Union{String, Nothing}=nothing)
    app_url::String = "https://prismajl.onrender.com"
    if os === nothing
        if Base.Sys.isapple() == true return Base.run(`open $app_url`)
        elseif Base.Sys.iswindows() == true return Base.run(`start $app_url`)
        elseif Base.Sys.islinux() == true return Base.run(`xdg-open $app_url`)
        end
    else
        if os == "macos" return Base.run(`open $app_url`)
        elseif os == "windows" return Base.run(`start $app_url`)
        elseif os == "linux" return Base.run(`xdg-open $app_url`)
        else return Base.error("Unsupported operating system: $os")
        end
    end
end

"""
    docs(; os::Union{String, Nothing}=nothing)

Open the PRISMA.jl documentation.

# Arguments
- `os::Union{String, Nothing}=nothing`: The operating system to use. If `nothing`, the default value is used.
"""
function docs(; os::Union{String, Nothing}=nothing)
    documentation_url::String = "https://cecoeco.github.io/PRISMA.jl"
    if os === nothing
        if Base.Sys.isapple() == true return Base.run(`open $documentation_url`)
        elseif Base.Sys.iswindows() == true return Base.run(`start $documentation_url`)
        elseif Base.Sys.islinux() == true return Base.run(`xdg-open $documentation_url`)
        end
    else
        if os == "macos" return Base.run(`open $documentation_url`)
        elseif os == "windows" return Base.run(`start $documentation_url`)
        elseif os == "linux" return Base.run(`xdg-open $documentation_url`)
        else return Base.error("Unsupported operating system: $os")
        end
    end
end

"""
    statement(; os::Union{String, Nothing}=nothing)

Open the PRISMA statement.

# Arguments
- `os::Union{String, Nothing}=nothing`: The operating system to use. If `nothing`, the default value is used.
"""
function statement(; os::Union{String, Nothing}=nothing)
    statement_url::String = "https://prisma-statement.org"
    if os === nothing
        if Base.Sys.isapple() == true return Base.run(`open $statement_url`)
        elseif Base.Sys.iswindows() == true return Base.run(`start $statement_url`)
        elseif Base.Sys.islinux() == true return Base.run(`xdg-open $statement_url`)
        end
    else
        if os == "macos" return Base.run(`open $statement_url`)
        elseif os == "windows" return Base.run(`start $statement_url`)
        elseif os == "linux" return Base.run(`xdg-open $statement_url`)
        else return Base.error("Unsupported operating system: $os")
        end
    end
end

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