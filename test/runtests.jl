using CSV
using DataFrames
using HTMLTables
using JSON3
using JSONTables
using PRISMA
using Test
using XLSX

@testset "checklist" begin
    df::DataFrame = PRISMA.checklist_df()

    CSV.write("checklist.csv", df)
    @test Base.Filesystem.isfile("checklist.csv")

    XLSX.writetable("checklist.xlsx", "PRISMA Checklist" => df)
    @test Base.Filesystem.isfile("checklist.xlsx")

    HTMLTables.write("checklist.html", df)
    @test Base.Filesystem.isfile("checklist.html")

    JSON3.write("checklist.json", JSONTables.objecttable(df))
    @test Base.Filesystem.isfile("checklist.json")

    # remove the files
    Base.Filesystem.rm("checklist.csv")
    Base.Filesystem.rm("checklist.xlsx")
    Base.Filesystem.rm("checklist.html")
    Base.Filesystem.rm("checklist.json")
end

@testset "flow_diagram" begin
    df::DataFrame = PRISMA.flow_diagram_df()
    fd::PRISMA.FlowDiagram = PRISMA.flow_diagram(df)

    PRISMA.flow_diagram_save("flow_diagram.svg", fd, overwrite=true)
    @test Base.Filesystem.isfile("flow_diagram.svg")

    PRISMA.flow_diagram_save("flow_diagram.png", fd, overwrite=true)
    @test Base.Filesystem.isfile("flow_diagram.png")

    PRISMA.flow_diagram_save("flow_diagram.pdf", fd, overwrite=true)
    @test Base.Filesystem.isfile("flow_diagram.pdf")

    PRISMA.flow_diagram_save("flow_diagram.dot", fd, overwrite=true)
    @test Base.Filesystem.isfile("flow_diagram.dot")

    # remove the files
    Base.Filesystem.rm("flow_diagram.svg")
    Base.Filesystem.rm("flow_diagram.png")
    Base.Filesystem.rm("flow_diagram.pdf")
    Base.Filesystem.rm("flow_diagram.dot")
end
