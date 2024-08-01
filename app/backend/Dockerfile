FROM julia:1.10

COPY app.jl .

RUN julia -e 'using Pkg; Pkg.add(["CSV", "DataFrames", "HTMLTables", "HTTP", "JSON3", "JSONTables", "Oxygen" "PRISMA"]);'

EXPOSE 5050

CMD julia app.jl