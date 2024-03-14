FROM julia:1.10
RUN useradd -m -s /bin/bash -u 10001 appuser
WORKDIR /backend
COPY Project.toml Manifest.toml ./
RUN julia --project -e 'using Pkg; Pkg.instantiate()'
COPY src/ ./src/
EXPOSE 5050
USER appuser
ENTRYPOINT [ "julia", "--project", "src/app.jl" ]
