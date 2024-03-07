using Documenter
using DocumenterCitations
using PRISMA

bib_filepath = Base.joinpath(Base.dirname(@__FILE__), "src/assets/references.bib")
bib = DocumenterCitations.CitationBibliography(bib_filepath, style=:authoryear)

Documenter.makedocs(
    modules=[PRISMA],
    format=Documenter.HTML(
        assets=[
            "src/assets/bib.css", 
            "src/assets/favicon.ico"
        ]
    ),
    sitename="PRISMA.jl",
    authors="Ceco Elijah Maples",
    pages=[
        "Home" => "index.md",
        "Manual" => [
            "App" => "app.md",
            "Checklist" => "checklist.md",
            "Flow Diagram" => "flow_diagram.md",
            "Other" => "other.md",
        ],
        "References" => "references.md"
    ],
    plugins=[bib]
)

Documenter.deploydocs(
    repo="github.com/cecoeco/PRISMA.jl.git"
)
