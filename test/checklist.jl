@testset "checklist" begin
    csv = PRISMA.checklist_csv()
    @test typeof(csv) == String
    @test isfile(csv) == true
    @test csv == Base.pwd() * "/" * "checklist.csv"

    json = PRISMA.checklist_json()
    @test typeof(json) == String
    @test isfile(json) == true
    @test json == Base.pwd() * "/" * "checklist.json"

    xlsx = PRISMA.checklist_xlsx()
    @test typeof(xlsx) == String
    @test isfile(xlsx) == true
    @test xlsx == Base.pwd() * "/" * "checklist.xlsx"

    checklist_csv = PRISMA.checklist_read(csv)
    @test typeof(checklist_csv) == DataFrame

    checklist_json = PRISMA.checklist_read(json)
    @test typeof(checklist_json) == DataFrame

    checklist_xlsx = PRISMA.checklist_read(xlsx)
    @test typeof(checklist_xlsx) == DataFrame
end