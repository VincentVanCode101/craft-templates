#!/bin/bash
# Bash script for managing Rust workflows inside a Docker container

# Application and paths
APP_NAME="{PROJECT_NAME}"
SRC_DIR="src"
BUILD_DIR="target"
BIN_PATH="${BUILD_DIR}/release/${APP_NAME}"

# Function to print usage information
usage() {
    echo "Usage: $0 {all|build|debug-build|run|test|lint|format|clean|watch}"
    exit 1
}

# If no argument is provided, default to "build"
COMMAND=${1:-build}

case "${COMMAND}" in
    all|build)
        echo "Building the application in release mode..."
        cargo build --release
        ;;
    debug-build)
        echo "Building the application in debug mode..."
        cargo build
        ;;
    run)
        # Ensure the application is built first (release mode)
        echo "Building the application in release mode..."
        cargo build --release
        echo "Running the application..."
        # Execute the built binary. If it’s not executable, ensure permissions are correct.
        "${BIN_PATH}"
        ;;
    test)
        echo "Running tests..."
        cargo test
        ;;
    lint)
        echo "Running Clippy linter..."
        cargo clippy --all-targets --all-features -- -D warnings
        ;;
    format)
        echo "Formatting the code with rustfmt..."
        cargo fmt --all
        ;;
    clean)
        echo "Cleaning up build artifacts..."
        cargo clean
        ;;
    watch)
        echo "Starting watch mode for changes..."
        cargo watch -x build
        ;;
    *)
        usage
        ;;
esac
