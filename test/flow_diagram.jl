@testset "flow_diagram" begin
    csv = PRISMA.flow_diagram_csv()
    @test typeof(csv) == String
    @test isfile(csv) == true
    @test csv == Base.pwd() * "/" * "flow_diagram.csv"

    json = PRISMA.flow_diagram_json()
    @test typeof(json) == String
    @test isfile(json) == true
    @test json == Base.pwd() * "/" * "flow_diagram.json"

    xlsx = PRISMA.flow_diagram_xlsx()
    @test typeof(xlsx) == String
    @test isfile(xlsx) == true
    @test xlsx == Base.pwd() * "/" * "flow_diagram.xlsx"

    flow_diagram_csv = PRISMA.flow_diagram_read(csv)
    @test typeof(flow_diagram_csv) == DataFrame

    flow_diagram_json = PRISMA.flow_diagram_read(json)
    @test typeof(flow_diagram_json) == DataFrame

    flow_diagram_xlsx = PRISMA.flow_diagram_read(xlsx)
    @test typeof(flow_diagram_xlsx) == DataFrame

    figure_csv = PRISMA.flow_diagram(data=flow_diagram_csv)
    @test typeof(figure_csv) == Figure

    figure_json = PRISMA.flow_diagram(data=flow_diagram_json)
    @test typeof(figure_json) == Figure

    figure_xlsx = PRISMA.flow_diagram(data=flow_diagram_xlsx)
    @test typeof(figure_xlsx) == Figure

    figure_csv_path = flow_diagram_save(figure=figure_csv)
    figure_json_path = flow_diagram_save(figure=figure_json)
    figure_xlsx_path = flow_diagram_save(figure=figure_xlsx)
    @test figure_csv_path == figure_json_path == figure_xlsx_path
end