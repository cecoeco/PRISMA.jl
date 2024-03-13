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