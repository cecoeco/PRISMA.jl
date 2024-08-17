FROM julia:1.10
WORKDIR /backend
COPY . .
RUN julia --project -e "using Pkg; Pkg.instantiate()"
ENTRYPOINT [ "julia", "--project", "src/app.jl" ]