#!/bin/bash
# Bash script for building and running Go applications

# Application settings
BINARY_NAME="{PROJECT_NAME}"
MAIN_PACKAGE="./main.go"

# Function to show usage information
usage() {
    echo "Usage: $0 {all|build|linux-build|run|clean}"
    echo "Optionally, set the ARGS environment variable to override the default main package."
    exit 1
}

# If no command is provided, default to "build" (as 'all' does in the Makefile)
COMMAND=${1:-build}

# The 'all' target is equivalent to 'build'
if [ "$COMMAND" = "all" ]; then
    COMMAND="build"
fi

case "$COMMAND" in
    build)
        if [ -z "$ARGS" ]; then
            echo "Building the main project ($MAIN_PACKAGE)..."
            go build -o "$BINARY_NAME" "$MAIN_PACKAGE"
        else
            # Use the basename of ARGS (removing a trailing ".go", if present) as the output name
            OUTPUT=$(basename "$ARGS" .go)
            echo "Building $ARGS..."
            go build -o "$OUTPUT" "$ARGS"
        fi
        ;;
    linux-build)
        echo "Building for Linux (CGO_ENABLED=0 GOOS=linux)..."
        CGO_ENABLED=0 GOOS=linux go build -o "$BINARY_NAME" "$MAIN_PACKAGE"
        ;;
    run)
        if [ -z "$ARGS" ]; then
            echo "Running the main project ($BINARY_NAME)..."
            ./"$BINARY_NAME"
        else
            OUTPUT=$(basename "$ARGS" .go)
            echo "Running $ARGS..."
            ./"$OUTPUT"
        fi
        ;;
    clean)
        echo "Cleaning up Go build artifacts..."
        go clean
        ;;
    *)
        usage
        ;;
esac
