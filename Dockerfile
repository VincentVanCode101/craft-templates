FROM rocker/r-base:latest

# --- system libs for most common R packages. adjust via build‑arg if you need more ---
ARG DEPS="libcurl4-openssl-dev libssl-dev libxml2-dev"
RUN apt-get update \
    && apt-get install -y $DEPS \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

CMD ["tail", "-f", "/dev/null"]
