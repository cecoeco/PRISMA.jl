module TestPRISMA

using HTTP, PRISMA, Test

Test.@testset "checklist_df" begin
    Test.@test PRISMA.checklist_df() isa DataFrame

    #TODO add more tests for checklist_df
end

Test.@testset "checklist_template" begin
    PRISMA.checklist_template()
    Test.@test Base.Filesystem.isfile("checklist.csv")
    Test.@test PRISMA.checklist_read("checklist.csv") isa DataFrame
    Base.Filesystem.rm("checklist.csv", force=true)
end

Test.@testset "checklist" begin
    paper::String = "page-et-al-2021.pdf"
    cl::PRISMA.Checklist = PRISMA.checklist(paper)
    PRISMA.checklist_save("checklist.csv", cl)
    Test.@test Base.Filesystem.isfile("checklist.csv")
    Test.@test PRISMA.checklist_read("checklist.csv") isa DataFrame
    Base.Filesystem.rm("checklist.csv", force=true)
end

Test.@testset "checklist pdf bytes" begin
    bytes::Vector{UInt8} = Base.read("page-et-al-2021.pdf")
    cl::PRISMA.Checklist = PRISMA.checklist(bytes)
    PRISMA.checklist_save("checklist.csv", cl)
    Test.@test Base.Filesystem.isfile("checklist.csv")
    Test.@test PRISMA.checklist_read("checklist.csv") isa DataFrame
    Base.Filesystem.rm("checklist.csv", force=true)
end

Test.@testset "plotting checklist" begin
    url::String = "https://www.bmj.com/content/bmj/372/bmj.n71.full.pdf"
    response::HTTP.Messages.Response = HTTP.get(url)
    pdf::Vector{UInt8} = response.body
    cl::PRISMA.Checklist = PRISMA.checklist(pdf)

    io::IO = IOBuffer()
    Base.show(io, cl)
    output::String = String(Base.take!(io))
    Test.@test Base.occursin("DataFrame", output)
    Test.@test Base.occursin("Dict", output)

    io_txt::IO = IOBuffer()
    Base.show(io_txt, Base.Multimedia.MIME("text/plain"), cl)
    output_txt::String = String(Base.take!(io_txt))
    Test.@test Base.occursin("DataFrame", output_txt)
    Test.@test Base.occursin("Dict", output_txt)

    io_csv::IO = IOBuffer()
    Base.show(io_csv, Base.Multimedia.MIME("text/csv"), cl)
    output_csv::String = String(Base.take!(io_csv))

    Test.@test Base.occursin("Section and Topic,Item #,Checklist Item,Location where item is reported", output_csv)
    Test.@test Base.occursin("TITLE,,,", output_csv)
    Test.@test Base.occursin("ABSTRACT,,,", output_csv)
    Test.@test Base.occursin("INTRODUCTION,,,", output_csv)
    Test.@test Base.occursin("METHODS,,,", output_csv)
    Test.@test Base.occursin("RESULTS,,,", output_csv)
    Test.@test Base.occursin("DISCUSSION,,,", output_csv)
    Test.@test Base.occursin("OTHER INFORMATION,,,", output_csv)
end

Test.@testset "flow_diagram_df" begin
    Test.@test PRISMA.flow_diagram_df() isa DataFrame

    #TODO add more tests for flow_diagram_df
end

Test.@testset "flow_diagram_template" begin
    PRISMA.flow_diagram_template()
    Test.@test Base.Filesystem.isfile("flow_diagram.csv")
    Test.@test PRISMA.flow_diagram_read("flow_diagram.csv") isa DataFrame
    Base.Filesystem.rm("flow_diagram.csv", force=true)
end

Test.@testset "flow_diagram" begin
    fd::PRISMA.FlowDiagram = PRISMA.flow_diagram()

    PRISMA.flow_diagram_save("flow_diagram.svg", fd)
    Test.@test Base.Filesystem.isfile("flow_diagram.svg")
    Base.Filesystem.rm("flow_diagram.svg", force=true)

    io_svg_01::IO = IOBuffer()
    PRISMA.flow_diagram_save(io_svg_01, fd)
    output::String = String(Base.take!(io_svg_01))
    Test.@test Base.occursin("<svg", output)
    Base.close(io_svg_01)

    io_svg_02::IO = IOBuffer()
    Base.show(io_svg_02, Base.Multimedia.MIME("image/svg+xml"), fd)
    output_svg::String = String(Base.take!(io_svg_02))
    Test.@test Base.occursin("<svg", output_svg)
    Base.close(io_svg_02)
end

end # module