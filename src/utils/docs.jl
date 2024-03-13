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