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


using PRISMA

data = PRISMA.flow_diagram_xlsx(filename="PRISMA_2020_flow_diagram_data")
df = PRISMA.flow_diagram_read(data)
figure = PRISMA.flow_diagram(df)
PRISMA.flow_diagram_save(figure, "PRISMA_2020_flow_diagram_example", "svg")