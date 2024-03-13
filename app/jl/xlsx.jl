using PRISMA

xlsx_path = PRISMA.flow_diagram_xlsx(success_message=false)
xlsx_string = Base.String(Base.read(xlsx_path))
Base.Filesystem.rm(xlsx_path)
Base.println(xlsx_string)