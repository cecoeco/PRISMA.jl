using PRISMA

csv_path = PRISMA.flow_diagram_csv(success_message=false)
csv_string = Base.String(Base.read(csv_path))
Base.Filesystem.rm(csv_path)
Base.println(csv_string)