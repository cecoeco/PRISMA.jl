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