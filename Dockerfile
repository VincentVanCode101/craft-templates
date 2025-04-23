FROM golang:1.24.2 AS dev
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

RUN go install golang.org/x/lint/golint@latest

COPY . .

ENTRYPOINT [ "./make linux-build" ]