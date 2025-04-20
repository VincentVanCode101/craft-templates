FROM rocker/r-base:latest

WORKDIR /usr/src/app

CMD ["tail", "-f", "/dev/null"]
