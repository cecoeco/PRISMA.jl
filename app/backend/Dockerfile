FROM julia:1.10

COPY app.jl .

RUN julia -e 'using Pkg; Pkg.add(["Base64","CSV","DataFrames","HTMLTables","HTTP","JSON3","JSONTables","Oxygen","PRISMA"])'

CMD julia app.jl
