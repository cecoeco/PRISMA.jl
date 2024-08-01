FROM julia:1.10

WORKDIR /

COPY app.jl .

RUN julia -e 'using Pkg;\
    Pkg.add(name="CSV",        version="0.10");\
    Pkg.add(name="DataFrames", version="1.6");\
    Pkg.add(name="HTMLTables", version="0.4");\
    Pkg.add(name="HTTP",       version="1.10");\
    Pkg.add(name="JSON3",      version="1.14");\
    Pkg.add(name="JSONTables", version="1");\
    Pkg.add(name="Oxygen",     version="1.5");\
    Pkg.add(name="PRISMA",     version="0.0.2");\
    '

EXPOSE 5050

CMD julia app.jl
