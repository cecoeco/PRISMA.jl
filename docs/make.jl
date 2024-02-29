using Documenter, PRISMA

makedocs(;
    modules=[PRISMA],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
        "Guide" => "guide.md",
        "API" => "api.md",
    ],
    repo="https://github.com/cecoeco/PRISMA.jl",
    sitename="PRISMA.jl",
    authors="Ceco E. Maples",
    assets=[],
)

deploydocs(;
    repo="github.com/cecoeco/PRISMA.jl",
)
