FROM julia:1.10

WORKDIR /app

COPY . .

RUN julia -e '\
    using Pkg; \
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