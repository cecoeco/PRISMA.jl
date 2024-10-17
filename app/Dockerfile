FROM julia:latest

WORKDIR /app

COPY . .

RUN julia --project -e "using Pkg; Pkg.instantiate(); Pkg.precompile()"

RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

ENTRYPOINT [ "julia", "--project", "src-oxygen/app.jl" ]