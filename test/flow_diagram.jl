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
end