using Documenter, DocumenterCitations, PRISMA

Documenter.makedocs(
    modules=[PRISMA],
    format=Documenter.HTML(assets=["src/assets/bib.css", "src/assets/favicon.ico"]),
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
            Base.Filesystem.joinpath(
                Base.Filesystem.dirname(Base.@__FILE__), 
                "src/assets/references.bib"
            ), 
            style=:authoryear
        )
    ]
)

Documenter.deploydocs(repo="github.com/cecoeco/PRISMA.jl.git")
