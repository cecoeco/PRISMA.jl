function bytes(fd::FlowDiagram, format::AbstractString="svg")
    temp_gv::String = Base.Filesystem.tempname() * ".gv"
    Base.Filesystem.write(temp_gv, fd.dot)
    try
        return Base.read(`$(neato()) $temp_gv -T$format`, String)
    catch e
        Base.rethrow(e)
    finally
        Base.Filesystem.rm(temp_gv, force=true)
    end
end

function Base.show(io::IO, fd::FlowDiagram)::Nothing
    Base.print(io, fd.dot)

    return nothing
end

function Base.show(io::IO, ::MIME"text/vnd.graphviz", fd::FlowDiagram)::Nothing
    Base.print(io, MIME("text/vnd.graphviz"), fd.dot)

    return nothing
end

function Base.show(io::IO, ::MIME"image/png", fd::FlowDiagram)::Nothing
    Base.print(io, bytes(fd, "png"))

    return nothing
end

function Base.show(io::IO, ::MIME"image/svg+xml", fd::FlowDiagram)::Nothing
    Base.print(io, bytes(fd, "svg"))

    return nothing
end

function Base.show(io::IO, ::MIME"application/pdf", fd::FlowDiagram)::Nothing
    Base.print(io, bytes(fd, "pdf"))

    return nothing
end

function Base.Multimedia.display(fd::FlowDiagram)::Nothing
    Base.Multimedia.display(MIME("image/svg+xml"), bytes(fd, "svg"))

    return nothing
end

function Base.show(io::IO, cl::Checklist)::Nothing
    Base.print(io, "$(cl.metadata["title"])")
    Base.print(io, "\n\nMetadata:\n\n")
    Base.print(io, cl.metadata)
    Base.print(io, "\n\n2020 PRISMA Checklist:\n\n")
    Base.print(io, cl.df)

    return nothing
end

function Base.show(io::IO, ::MIME"text/plain", cl::Checklist)::Nothing
    Base.print(io, "$(cl.metadata["title"])")
    Base.print(io, "\n\nMetadata:\n\n")
    Base.print(io, cl.metadata)
    Base.print(io, "\n\n2020 PRISMA Checklist:\n\n")
    Base.print(io, cl.df)

    return nothing
end

function Base.show(io::IO, ::MIME"text/csv", cl::Checklist)::Nothing
    Base.print(io, "$(cl.metadata["title"])")
    Base.print(io, "\n\nMetadata:\n\n")
    Base.print(io, CSV.write(io, DataFrame(cl.metadata)))
    Base.print(io, "\n\n2020 PRISMA Checklist:\n\n")
    Base.print(io, CSV.write(io, cl.df))

    return nothing
end

function Base.show(io::IO, ::MIME"text/html", cl::Checklist)::Nothing
    Base.print(io, "$(cl.metadata["title"])")
    Base.print(io, "\n\nMetadata:\n\n")
    Base.print(io, HTMLTables.table(DataFrame(cl.metadata)))
    Base.print(io, "\n\n2020 PRISMA Checklist:\n\n")
    Base.print(io, HTMLTables.table(cl.df))

    return nothing
end

function Base.show(io::IO, ::MIME"application/json", cl::Checklist)::Nothing
    Base.print(io, "$(cl.metadata["title"])")
    Base.print(io, "\n\nMetadata:\n\n")
    Base.print(io, JSON3.pretty(io, cl.metadata))
    Base.print(io, "\n\n2020 PRISMA Checklist:\n\n")
    Base.print(io, JSON3.pretty(io, JSONTables.objecttable(cl.df)))

    return nothing
end
