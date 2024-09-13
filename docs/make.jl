using Documenter, DocumenterCitations, PRISMA

const ASSETS::String = joinpath(dirname(@__FILE__), "src/assets")

Documenter.makedocs(
    modules=[PRISMA],
    format=Documenter.HTML(
        assets=[
            "assets/bib.css",
            "assets/favicon.ico"
        ]
    ),
    sitename="PRISMA.jl",
    authors="Ceco Elijah Maples and Contributors",
    pages=[
        "Home" => "index.md",
        "Checklist" => "checklist.md",
        "Flow Diagram" => "flow_diagram.md",
        "References" => "references.md"
    ],
    plugins=[
        DocumenterCitations.CitationBibliography(
            joinpath(ASSETS, "references.bib"),
            style=:numeric
        )
    ]
)

Documenter.deploydocs(repo="github.com/cecoeco/PRISMA.jl.git")
