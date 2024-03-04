using Documenter
using PRISMA

Documenter.makedocs(;
    modules=[PRISMA],
    format=Documenter.HTML(),
    pages=["index.md"],
    repo="https://github.com/cecoeco/PRISMA.jl",
    sitename="PRISMA.jl",
    authors="Ceco E. Maples"
)

Documenter.deploydocs(;
    repo="github.com/cecoeco/PRISMA.jl.git",
)
