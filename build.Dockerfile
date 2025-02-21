FROM php:8.2-alpine AS builder

WORKDIR /build-space

ARG UID=1000
ARG GID=1000
ARG PROJECT_NAME=default-project-name

RUN apk update && apk add --no-cache curl git unzip bash

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

RUN symfony new --no-git --no-interaction --webapp .

RUN chown -R ${UID}:${GID} /build-space
