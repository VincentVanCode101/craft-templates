FROM ubuntu:latest

WORKDIR /build-space

ARG UID=1000
ARG GID=1000
ARG PROJECT_NAME=default-project-name

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    php-cli \
    php-mbstring \
    php-xml \
    php-curl \
    php-zip \
    php-intl \
    php-tokenizer \
    php-mysql \
    php-bcmath \
    php-ctype \
    php-iconv \
    php-gd \
    php-pdo \
    php-opcache \
    php-simplexml \
    php-dom \
    php-xmlwriter \
    php-xmlreader \
    php-phar \
    php-json \
    php-fileinfo \
    php-tokenizer \
    php-curl \
    php-zip \
    php-intl \
    php-mysql \
    php-bcmath \
    php-ctype \
    php-iconv \
    php-gd \
    php-pdo \
    php-opcache \
    php-simplexml \
    php-dom \
    php-xmlwriter \
    php-xmlreader \
    php-phar \
    php-json \
    php-fileinfo \
    && apt-get clean

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Set working directory (volume will be mounted here)
RUN symfony new --no-git --no-interaction --version=lts --webapp .

RUN chown -R 1000:1000 /build-space