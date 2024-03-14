FROM julia:1.10

WORKDIR /backend
COPY Project.toml Manifest.toml ./
RUN julia --project -e 'using Pkg; Pkg.instantiate()'
COPY src/ ./src/

EXPOSE 5050

ENTRYPOINT [ "julia", "--project", "src/app.jl" ]