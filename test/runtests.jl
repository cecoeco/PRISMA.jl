using HTTP, PRISMA, Test

Test.@testset "checklist_df" begin
	df::DataFrame = PRISMA.checklist_df()

	PRISMA.checklist_save("checklist.csv", df)
	Test.@test Base.Filesystem.isfile("checklist.csv")
	Test.@test PRISMA.checklist_read("checklist.csv") isa DataFrame

	PRISMA.checklist_save("checklist.xlsx", df)
	Test.@test Base.Filesystem.isfile("checklist.xlsx")
	Test.@test PRISMA.checklist_read("checklist.xlsx") isa DataFrame

	PRISMA.checklist_save("checklist.html", df)
	Test.@test Base.Filesystem.isfile("checklist.html")
	Test.@test PRISMA.checklist_read("checklist.html") isa DataFrame

	PRISMA.checklist_save("checklist.json", df)
	Test.@test Base.Filesystem.isfile("checklist.json")
	Test.@test PRISMA.checklist_read("checklist.json") isa DataFrame

	# remove the files
	Base.Filesystem.rm("checklist.csv")
	Base.Filesystem.rm("checklist.xlsx")
	Base.Filesystem.rm("checklist.html")
	Base.Filesystem.rm("checklist.json")
end

Test.@testset "checklist" begin
	url::String = "https://www.bmj.com/content/bmj/372/bmj.n71.full.pdf"
	response::HTTP.Messages.Response = HTTP.get(url)
	pdf::Vector{UInt8} = response.body

	cl::PRISMA.Checklist = PRISMA.checklist(pdf)

	#cl::PRISMA.Checklist = PRISMA.checklist("page-et-al-2021.pdf")

	PRISMA.checklist_save("checklist.csv", cl)
	Test.@test Base.Filesystem.isfile("checklist.csv")
	Test.@test PRISMA.checklist_read("checklist.csv") isa DataFrame

	PRISMA.checklist_save("checklist.xlsx", cl)
	Test.@test Base.Filesystem.isfile("checklist.xlsx")
	Test.@test PRISMA.checklist_read("checklist.xlsx") isa DataFrame

	PRISMA.checklist_save("checklist.html", cl)
	Test.@test Base.Filesystem.isfile("checklist.html")
	Test.@test PRISMA.checklist_read("checklist.html") isa DataFrame

	PRISMA.checklist_save("checklist.json", cl)
	Test.@test Base.Filesystem.isfile("checklist.json")
	Test.@test PRISMA.checklist_read("checklist.json") isa DataFrame

	# remove the files
	Base.Filesystem.rm("checklist.csv")
	Base.Filesystem.rm("checklist.xlsx")
	Base.Filesystem.rm("checklist.html")
	Base.Filesystem.rm("checklist.json")
end

Test.@testset "flow_diagram_df" begin
	df::DataFrame = PRISMA.flow_diagram_df()

	PRISMA.flow_diagram_save("flow_diagram.csv", df)
	Test.@test Base.Filesystem.isfile("flow_diagram.csv")
	Test.@test PRISMA.flow_diagram_read("flow_diagram.csv") isa DataFrame

	PRISMA.flow_diagram_save("flow_diagram.xlsx", df)
	Test.@test Base.Filesystem.isfile("flow_diagram.xlsx")
	Test.@test PRISMA.flow_diagram_read("flow_diagram.xlsx") isa DataFrame

	PRISMA.flow_diagram_save("flow_diagram.html", df)
	Test.@test Base.Filesystem.isfile("flow_diagram.html")
	Test.@test PRISMA.flow_diagram_read("flow_diagram.html") isa DataFrame

	PRISMA.flow_diagram_save("flow_diagram.json", df)
	Test.@test Base.Filesystem.isfile("flow_diagram.json")
	Test.@test PRISMA.flow_diagram_read("flow_diagram.json") isa DataFrame

	# remove the files
	Base.Filesystem.rm("flow_diagram.csv")
	Base.Filesystem.rm("flow_diagram.xlsx")
	Base.Filesystem.rm("flow_diagram.html")
	Base.Filesystem.rm("flow_diagram.json")
end

Test.@testset "flow_diagram" begin
	fd::PRISMA.FlowDiagram = PRISMA.flow_diagram(
		background_color = "white",
		grayboxes = false,
		grayboxes_color = "white",
		top_boxes = true,
		top_boxes_borders = true,
		top_boxes_color = "white",
		side_boxes = true,
		side_boxes_borders = true,
		side_boxes_color = "white",
		previous_studies = true,
		other_methods = true,
		borders = true,
		border_style = "solid",
		border_width = 1,
		border_color = "black",
		font = "Arial",
		font_color = "black",
		font_size = 10,
		arrow_head = "normal",
		arrow_size = 1,
		arrow_color = "black",
		arrow_width = 1,
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

Test.@testset "plotting checklist" begin
	#=
	url::String = "https://www.bmj.com/content/bmj/372/bmj.n71.full.pdf"
	response::HTTP.Messages.Response = HTTP.get(url)
	pdf::Vector{UInt8} = response.body
	=#

	cl::PRISMA.Checklist = PRISMA.checklist("page-et-al-2021.pdf")

	io::IO = IOBuffer()
	Base.show(io, cl)
	output::String = String(Base.take!(io))
	Test.@test Base.occursin("DataFrame", output)
	Test.@test Base.occursin("LittleDict", output)

	io_text::IO = IOBuffer()
	Base.show(io_text, Base.Multimedia.MIME("text/plain"), cl)
	output_text::String = String(Base.take!(io_text))
	Test.@test Base.occursin("DataFrame", output_text)
	Test.@test Base.occursin("LittleDict", output_text)

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

	io_html::IO = IOBuffer()
	Base.show(io_html, Base.Multimedia.MIME("text/html"), cl)
	output_html::String = String(Base.take!(io_html))
	Test.@test Base.occursin("<table", output_html)

	io_json::IO = IOBuffer()
	Base.show(io_json, Base.Multimedia.MIME("application/json"), cl)
	output_json::String = String(Base.take!(io_json))
	Test.@test Base.occursin("{", output_json)
end

Test.@testset "plotting flow_diagram" begin
	fd::PRISMA.FlowDiagram = PRISMA.flow_diagram()

	io::IO = IOBuffer()
	Base.show(io, fd)
	output::String = String(Base.take!(io))
	Test.@test Base.occursin("digraph", output)

	io_text::IO = IOBuffer()
	Base.show(io_text, Base.Multimedia.MIME("text/plain"), fd)
	output_text::String = String(Base.take!(io_text))
	Test.@test Base.occursin("digraph", output_text)

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
