function open(os::Union{String, Nothing}=nothing, resources::Bool=false)
    url::String = "http://127.0.0.1"
    os_command = os === nothing ?
        (Sys.isapple() ? `open $url` : (Sys.iswindows() ? `start $url` : `xdg-open $url`)) :
        (os == "macos" ? `open $url` : (os == "windows" ? `start $url` : (os == "linux" ? `xdg-open $url` : "Unsupported operating system: $os")))
    Base.run(os_command)

    (resources == true && os === nothing) && Base.run("open https://www.prisma-statement.org/")
    (resources == true && os == "macos") && Base.run(`open https://www.prisma-statement.org/`)
    (resources == true && os == "windows") && Base.run(`start https://www.prisma-statement.org/`)
    (resources == true && os == "linux") && Base.run(`xdg-open https://www.prisma-statement.org/`)
end