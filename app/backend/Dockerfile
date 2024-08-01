FROM julia:1.10

COPY . .

RUN julia -e '\
    Pkg.add("CSV");\
    Pkg.add("DataFrames");\
    Pkg.add("HTMLTables");\
    Pkg.add("HTTP");\
    Pkg.add("JSON3");\
    Pkg.add("JSONTables");\
    Pkg.add("PRISMA");\
    Pkg.precompile();\
    '

EXPOSE 5050

CMD ["julia", "app.jl"]