using Documenter
using PRISMA

Documenter.makedocs(;
    modules=[PRISMA],
    format=Documenter.HTML(),
    repo="https://github.com/cecoeco/PRISMA.jl",
    sitename="PRISMA.jl",
    authors="Ceco E. Maples",
    doctest=false,
)

Documenter.deploydocs(;
    repo="github.com/cecoeco/PRISMA.jl.git",
)
