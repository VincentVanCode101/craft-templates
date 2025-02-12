#!/bin/bash
# Bash script for building, testing, and running Go applications

# Application settings
BINARY_NAME="{PROJECT_NAME}"
MAIN_PACKAGE="./main.go"

# Function to display usage information
usage() {
    echo "Usage: $0 {all|build|linux-build|run|test|clean} [FILE]"
    echo ""
    echo "  FILE (optional) - When provided with build or run, overrides the default main package."
    exit 1
}

# Read the first and second command-line arguments.
COMMAND="$1"
FILE="$2"

# If no command is provided, default to "build"
if [ -z "$COMMAND" ]; then
    COMMAND="build"
fi

# The 'all' target is equivalent to 'build'
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
        # If FILE ends with ".go", remove the extension to form the output binary name.
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
    if [ -z "$FILE" ]; then
        echo "Running the main project ($BINARY_NAME)..."
        ./"$BINARY_NAME"
    else
        # If FILE ends with ".go", remove the extension to get the binary name.
        if [[ "$FILE" == *.go ]]; then
            OUTPUT=$(basename "$FILE" .go)
        else
            OUTPUT=$(basename "$FILE")
        fi
        echo "Running $FILE (binary: $OUTPUT)..."
        ./"$OUTPUT"
    fi
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
