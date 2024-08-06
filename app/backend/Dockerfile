FROM julia:1.10

COPY app.jl .

RUN julia -e 'using Pkg; Pkg.add(["CSV","DataFrames","HTMLTables","HTTP","JSONTables","Oxygen","PRISMA"])'

CMD julia app.jl
