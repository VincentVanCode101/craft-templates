#!/usr/bin/env bash
# Bash script for building, testing, and running Go applications

# Application settings
BINARY_NAME="{PROJECT_NAME}"
MAIN_PACKAGE="./main.go"

# Function to display usage information
usage() {
    echo "Usage: $0 {all|build|linux-build|run|test|clean|install-package} [FILE]"
    echo ""
    echo "  FILE (optional) - When provided with build or run, overrides the default main package."
    exit 1
}

COMMAND="$1"
FILE="$2"

if [ -z "$COMMAND" ]; then
    COMMAND="build"
fi

if [ "$COMMAND" = "all" ]; then
    COMMAND="build"
fi

case "$COMMAND" in
build)
    if [ -z "$FILE" ]; then
        echo "Building the main project ($MAIN_PACKAGE)..."
        go build -o "$BINARY_NAME" "$MAIN_PACKAGE"
        chmod +x "$BINARY_NAME"
    else
        if [[ "$FILE" == *.go ]]; then
            OUTPUT=$(basename "$FILE" .go)
        else
            OUTPUT=$(basename "$FILE")
        fi
        echo "Building $FILE..."
        go build -o "$OUTPUT" "$FILE"
        chmod +x "$OUTPUT"
    fi
    ;;
linux-build)
    echo "Building for Linux (CGO_ENABLED=0 GOOS=linux)..."
    CGO_ENABLED=0 GOOS=linux go build -o "$BINARY_NAME" "$MAIN_PACKAGE"
    chmod +x "$BINARY_NAME"
    ;;
run)
    shift
    FILE="$1"
    shift
    if [ -z "$FILE" ]; then
        echo "Running the main project ($BINARY_NAME) with args: $@"
        ./"$BINARY_NAME" "$@"
    else
        if [[ "$FILE" == *.go ]]; then
            OUTPUT=$(basename "$FILE" .go)
        else
            OUTPUT=$(basename "$FILE")
        fi
        echo "Running $FILE (binary: $OUTPUT) with args: $@"
        ./"$OUTPUT" "$@"
    fi
    ;;
install-package)
    echo "Installing Go packages..."
    go mod download
    ;;
test)
    echo "Running tests..."
    go test ./...
    ;;
clean)
    echo "Cleaning up Go build artifacts..."
    go clean
    ;;
*)
    usage
    ;;
esac
