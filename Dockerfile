FROM php:8.2-fpm-alpine

ENV DEBIAN_FRONTEND=noninteractive

RUN apk add --no-cache \
    curl \
    unzip \
    git \
    nodejs \
    npm \
    bash \
    && npm install -g yarn

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | /bin/bash && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

WORKDIR /var/www/symfony

CMD ["/bin/sh"]
