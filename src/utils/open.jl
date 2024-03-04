"""
    open(os::Union{String, Nothing}=nothing, resources::Bool=false)

Open the PRISMA web application.

# Arguments
- `os::Union{String, Nothing}=nothing`: The operating system to use. If `nothing`, the default value is used.
- `resources::Bool=false`: Whether to open the resources page.
"""
function open(os::Union{String, Nothing}=nothing, resources::Bool=false)
    app_url::String = "https://prisma-jl.onrender.com"
    documentation_url::String = "tba"
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