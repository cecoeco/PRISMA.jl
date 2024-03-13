using PRISMA

json_path = PRISMA.flow_diagram_json(success_message=false)
json_string = Base.String(Base.read(json_path))
Base.Filesystem.rm(json_path)
Base.println(json_string)