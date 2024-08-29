FROM julia:latest
WORKDIR /backend
COPY . .
RUN julia --project -e "using Pkg; Pkg.instantiate(); Pkg.precompile()"
ENTRYPOINT [ "julia", "--project", "src/app.jl" ]