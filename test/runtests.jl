module TestPRISMA

using HTTP, PRISMA, Test

Test.@testset "checklist_df" begin
    PRISMA.checklist_template("checklist.csv")
    Test.@test Base.Filesystem.isfile("checklist.csv")
    Test.@test PRISMA.checklist_read("checklist.csv") isa DataFrame
    Base.Filesystem.rm("checklist.csv", force=true)
end

Test.@testset "checklist" begin
    cl::PRISMA.Checklist = PRISMA.checklist("page-et-al-2021.pdf")
    PRISMA.checklist_save("checklist.csv", cl)
    Test.@test Base.Filesystem.isfile("checklist.csv")
    Test.@test PRISMA.checklist_read("checklist.csv") isa DataFrame
    Base.Filesystem.rm("checklist.csv", force=true)
end

Test.@testset "flow_diagram_df" begin
    PRISMA.flow_diagram_template("flow_diagram.csv")
    Test.@test Base.Filesystem.isfile("flow_diagram.csv")
    Test.@test PRISMA.flow_diagram_read("flow_diagram.csv") isa DataFrame
    Base.Filesystem.rm("flow_diagram.csv", force=true)
end

Test.@testset "flow_diagram" begin
    fd::PRISMA.FlowDiagram = PRISMA.flow_diagram()

    PRISMA.flow_diagram_save("flow_diagram.svg", fd)
    Test.@test Base.Filesystem.isfile("flow_diagram.svg")

    PRISMA.flow_diagram_save("flow_diagram.png", fd)
    Test.@test Base.Filesystem.isfile("flow_diagram.png")

    PRISMA.flow_diagram_save("flow_diagram.pdf", fd)
    Test.@test Base.Filesystem.isfile("flow_diagram.pdf")

    PRISMA.flow_diagram_save("flow_diagram.dot", fd)
    Test.@test Base.Filesystem.isfile("flow_diagram.dot")

    # remove the files
    Base.Filesystem.rm("flow_diagram.svg", force=true)
    Base.Filesystem.rm("flow_diagram.png", force=true)
    Base.Filesystem.rm("flow_diagram.pdf", force=true)
    Base.Filesystem.rm("flow_diagram.dot", force=true)
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

Test.@testset "plotting flow_diagram" begin
    fd::PRISMA.FlowDiagram = PRISMA.flow_diagram()

    io::IO = IOBuffer()
    Base.show(io, fd)
    output::String = String(Base.take!(io))
    Test.@test Base.occursin("digraph", output)

    io_txt::IO = IOBuffer()
    Base.show(io_txt, Base.Multimedia.MIME("text/plain"), fd)
    output_txt::String = String(Base.take!(io_txt))
    Test.@test Base.occursin("digraph", output_txt)

    io_svg::IO = IOBuffer()
    Base.show(io_svg, Base.Multimedia.MIME("image/svg+xml"), fd)
    output_svg::String = String(Base.take!(io_svg))
    Test.@test Base.occursin("<svg", output_svg)

    io_png::IO = IOBuffer()
    Base.show(io_png, Base.Multimedia.MIME("image/png"), fd)
    output_png::Vector{UInt8} = Base.take!(io_png)
    Test.@test !Base.isempty(output_png)
    png_signature::Vector{UInt8} = UInt8[0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
    Test.@test output_png[1:8] == png_signature

    io_pdf::IO = IOBuffer()
    Base.show(io_pdf, Base.Multimedia.MIME("application/pdf"), fd)
    output_pdf::Vector{UInt8} = Base.take!(io_pdf)
    Test.@test !Base.isempty(output_pdf)
    pdf_signature::Vector{UInt8} = UInt8[0x25, 0x50, 0x44, 0x46]
    Test.@test output_pdf[1:4] == pdf_signature
end

end