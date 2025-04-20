FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

WORKDIR /app

RUN apt-get update

CMD ["tail", "-f", "/dev/null"]