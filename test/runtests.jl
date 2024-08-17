using PRISMA, Test

Test.@testset "checklist_df" begin
    df::DataFrame = PRISMA.checklist_df()

    PRISMA.checklist_save("checklist.csv", df, overwrite=true)
    Test.@test Base.Filesystem.isfile("checklist.csv")

    PRISMA.checklist_save("checklist.xlsx", df, overwrite=true)
    Test.@test Base.Filesystem.isfile("checklist.xlsx")

    PRISMA.checklist_save("checklist.html", df, overwrite=true)
    Test.@test Base.Filesystem.isfile("checklist.html")

    PRISMA.checklist_save("checklist.json", df, overwrite=true)
    Test.@test Base.Filesystem.isfile("checklist.json")

    # remove the files
    Base.Filesystem.rm("checklist.csv")
    Base.Filesystem.rm("checklist.xlsx")
    Base.Filesystem.rm("checklist.html")
    Base.Filesystem.rm("checklist.json")
end

Test.@testset "checklist" begin
    cl::PRISMA.Checklist = PRISMA.checklist("../docs/src/assets/bmj.n71.full.pdf")

    PRISMA.checklist_save("checklist.csv", cl, overwrite=true)
    Test.@test Base.Filesystem.isfile("checklist.csv")

    PRISMA.checklist_save("checklist.xlsx", cl, overwrite=true)
    Test.@test Base.Filesystem.isfile("checklist.xlsx")

    PRISMA.checklist_save("checklist.html", cl, overwrite=true)
    Test.@test Base.Filesystem.isfile("checklist.html")

    PRISMA.checklist_save("checklist.json", cl, overwrite=true)
    Test.@test Base.Filesystem.isfile("checklist.json")

    # remove the files
    Base.Filesystem.rm("checklist.csv")
    Base.Filesystem.rm("checklist.xlsx")
    Base.Filesystem.rm("checklist.html")
    Base.Filesystem.rm("checklist.json")
end

Test.@testset "flow_diagram_df" begin
    df::DataFrame = PRISMA.flow_diagram_df()

    PRISMA.flow_diagram_save("flow_diagram.csv", df, overwrite=true)
    Test.@test Base.Filesystem.isfile("flow_diagram.csv")

    PRISMA.flow_diagram_save("flow_diagram.xlsx", df, overwrite=true)
    Test.@test Base.Filesystem.isfile("flow_diagram.xlsx")

    PRISMA.flow_diagram_save("flow_diagram.html", df, overwrite=true)
    Test.@test Base.Filesystem.isfile("flow_diagram.html")

    PRISMA.flow_diagram_save("flow_diagram.json", df, overwrite=true)
    Test.@test Base.Filesystem.isfile("flow_diagram.json")

    # remove the files
    Base.Filesystem.rm("flow_diagram.csv")
    Base.Filesystem.rm("flow_diagram.xlsx")
    Base.Filesystem.rm("flow_diagram.html")
    Base.Filesystem.rm("flow_diagram.json")
end

Test.@testset "flow_diagram" begin
    fd::PRISMA.FlowDiagram = PRISMA.flow_diagram()

    PRISMA.flow_diagram_save("flow_diagram.svg", fd, overwrite=true)
    Test.@test Base.Filesystem.isfile("flow_diagram.svg")

    PRISMA.flow_diagram_save("flow_diagram.png", fd, overwrite=true)
    Test.@test Base.Filesystem.isfile("flow_diagram.png")

    PRISMA.flow_diagram_save("flow_diagram.pdf", fd, overwrite=true)
    Test.@test Base.Filesystem.isfile("flow_diagram.pdf")

    PRISMA.flow_diagram_save("flow_diagram.dot", fd, overwrite=true)
    Test.@test Base.Filesystem.isfile("flow_diagram.dot")

    # remove the files
    Base.Filesystem.rm("flow_diagram.svg")
    Base.Filesystem.rm("flow_diagram.png")
    Base.Filesystem.rm("flow_diagram.pdf")
    Base.Filesystem.rm("flow_diagram.dot")
end
