FROM ubuntu:latest

WORKDIR /build-space

ARG UID=1000
ARG GID=1000
ARG PROJECT_NAME=default-project-name

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl unzip git php-cli php-xml php-mbstring && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

RUN symfony new --no-git --no-interaction --webapp .

RUN chown -R ${UID}:${GID} /build-space
