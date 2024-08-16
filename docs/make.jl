using Documenter: makedocs, HTML, deploydocs
using DocumenterCitations: CitationBibliography
using PRISMA

makedocs(
    modules=[PRISMA],
    format=HTML(assets=["src/assets/bib.css", "src/assets/favicon.ico"]),
    sitename="PRISMA.jl",
    authors="Ceco Elijah Maples and contributors",
    pages=[
        "Home" => "index.md",
        "Checklist" => "checklist.md",
        "Flow Diagram" => "flow_diagram.md",
        "References" => "references.md"
    ],
    plugins=[CitationBibliography(joinpath(dirname(@__FILE__), "src/assets/references.bib"), style=:authoryear)]
)

deploydocs(repo="github.com/cecoeco/PRISMA.jl.git")
