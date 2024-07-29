FROM julia:1.10
COPY Project.toml Manifest.toml app.jl ./
RUN julia --project -e "using Pkg; Pkg.instantiate()"
ENTRYPOINT [ "julia", "--project", "app.jl" ]