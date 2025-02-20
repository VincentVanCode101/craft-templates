FROM ubuntu:latest

WORKDIR /build-space

ARG UID=1000
ARG GID=1000
ARG PROJECT_NAME=default-project-name

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install only required dependencies
RUN apt-get update && apt-get install -y \
    curl unzip git php-cli && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Generate Symfony Project
RUN symfony new --no-git --no-interaction --webapp .

# Ensure the host user has ownership
RUN chown -R ${UID}:${GID} /build-space
