using HTTP, PRISMA, Test

Test.@testset "checklist_df" begin
    df::DataFrame = PRISMA.checklist_df()

    PRISMA.checklist_save("checklist.csv", df)
    Test.@test Base.Filesystem.isfile("checklist.csv")
    Test.@test isa(PRISMA.checklist_read("checklist.csv"), DataFrame)

    PRISMA.checklist_save("checklist.xlsx", df)
    Test.@test Base.Filesystem.isfile("checklist.xlsx")
    Test.@test isa(PRISMA.checklist_read("checklist.xlsx"), DataFrame)

    PRISMA.checklist_save("checklist.html", df)
    Test.@test Base.Filesystem.isfile("checklist.html")
    Test.@test isa(PRISMA.checklist_read("checklist.html"), DataFrame)

    PRISMA.checklist_save("checklist.json", df)
    Test.@test Base.Filesystem.isfile("checklist.json")
    Test.@test isa(PRISMA.checklist_read("checklist.json"), DataFrame)

    # remove the files
    Base.Filesystem.rm("checklist.csv")
    Base.Filesystem.rm("checklist.xlsx")
    Base.Filesystem.rm("checklist.html")
    Base.Filesystem.rm("checklist.json")
end
#=
Test.@testset "checklist" begin
    url::String = "https://www.bmj.com/content/bmj/372/bmj.n71.full.pdf"
    response::HTTP.Messages.Response = 
    pdf::Vector{UInt8} = response.body

    cl::PRISMA.Checklist = PRISMA.checklist(pdf)

    PRISMA.checklist_save("checklist.csv", cl)
    Test.@test Base.Filesystem.isfile("checklist.csv")
    Test.@test isa(PRISMA.checklist_read("checklist.csv"), DataFrame)

    PRISMA.checklist_save("checklist.xlsx", cl)
    Test.@test Base.Filesystem.isfile("checklist.xlsx")
    Test.@test isa(PRISMA.checklist_read("checklist.xlsx"), DataFrame)

    PRISMA.checklist_save("checklist.html", cl)
    Test.@test Base.Filesystem.isfile("checklist.html")
    Test.@test isa(PRISMA.checklist_read("checklist.html"), DataFrame)

    PRISMA.checklist_save("checklist.json", cl)
    Test.@test Base.Filesystem.isfile("checklist.json")
    Test.@test isa(PRISMA.checklist_read("checklist.json"), DataFrame)

    # remove the files
    Base.Filesystem.rm("checklist.csv")
    Base.Filesystem.rm("checklist.xlsx")
    Base.Filesystem.rm("checklist.html")
    Base.Filesystem.rm("checklist.json")
end
=#
Test.@testset "flow_diagram_df" begin
    df::DataFrame = PRISMA.flow_diagram_df()

    PRISMA.flow_diagram_save("flow_diagram.csv", df)
    Test.@test Base.Filesystem.isfile("flow_diagram.csv")
    Test.@test isa(PRISMA.flow_diagram_read("flow_diagram.csv"), DataFrame)

    PRISMA.flow_diagram_save("flow_diagram.xlsx", df)
    Test.@test Base.Filesystem.isfile("flow_diagram.xlsx")
    Test.@test isa(PRISMA.flow_diagram_read("flow_diagram.xlsx"), DataFrame)

    PRISMA.flow_diagram_save("flow_diagram.html", df)
    Test.@test Base.Filesystem.isfile("flow_diagram.html")
    Test.@test isa(PRISMA.flow_diagram_read("flow_diagram.html"), DataFrame)

    PRISMA.flow_diagram_save("flow_diagram.json", df)
    Test.@test Base.Filesystem.isfile("flow_diagram.json")
    Test.@test isa(PRISMA.flow_diagram_read("flow_diagram.json"), DataFrame)

    # remove the files
    Base.Filesystem.rm("flow_diagram.csv")
    Base.Filesystem.rm("flow_diagram.xlsx")
    Base.Filesystem.rm("flow_diagram.html")
    Base.Filesystem.rm("flow_diagram.json")
end

Test.@testset "flow_diagram" begin
    fd::PRISMA.FlowDiagram = PRISMA.flow_diagram(
        flow_diagram_df(),
        background_color="white",
        grayboxes=false,
        grayboxes_color="#white",
        top_boxes=true,
        top_boxes_borders=true,
        top_boxes_color="white",
        side_boxes=true,
        side_boxes_borders=true,
        side_boxes_color="white",
        previous_studies=true,
        other_methods=true,
        borders=true,
        border_style="solid",
        border_width=1,
        border_color="black",
        font="Arial",
        font_color="black",
        font_size=10,
        arrow_head="normal",
        arrow_size=1,
        arrow_color="black",
        arrow_width=1
    )

    PRISMA.flow_diagram_save("flow_diagram.svg", fd)
    Test.@test Base.Filesystem.isfile("flow_diagram.svg")

    PRISMA.flow_diagram_save("flow_diagram.png", fd)
    Test.@test Base.Filesystem.isfile("flow_diagram.png")

    PRISMA.flow_diagram_save("flow_diagram.pdf", fd)
    Test.@test Base.Filesystem.isfile("flow_diagram.pdf")

    PRISMA.flow_diagram_save("flow_diagram.dot", fd)
    Test.@test Base.Filesystem.isfile("flow_diagram.dot")

    # remove the files
    Base.Filesystem.rm("flow_diagram.svg")
    Base.Filesystem.rm("flow_diagram.png")
    Base.Filesystem.rm("flow_diagram.pdf")
    Base.Filesystem.rm("flow_diagram.dot")
end