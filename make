#!/usr/bin/env bash
set -euo pipefail

COMMAND=${1:-}
PROJECT_NAME=${2:-}
PROJECT_DIR="./$PROJECT_NAME"

usage() {
    echo "Usage:"
    echo "  ./make new <project-name>     # Create a new console project"
    echo "  ./make build <project-name>   # Build the specified project"
    echo "  ./make run <project-name>     # Run the specified project"
    exit 1
}

# Ensure command and project name are present for valid commands
if [[ "$COMMAND" =~ ^(new|build|run)$ && -z "$PROJECT_NAME" ]]; then
    echo "Error: Project name is required for '$COMMAND'"
    usage
fi

case "$COMMAND" in
new)
    echo "Creating new C# console project: $PROJECT_NAME"
    dotnet new console -o "$PROJECT_NAME"
    ;;

build)
    echo "Building C# project: $PROJECT_NAME"
    dotnet build "$PROJECT_DIR"
    ;;

run)
    echo "Running C# project: $PROJECT_NAME"
    dotnet run --project "$PROJECT_DIR"
    ;;

*)
    usage
    ;;
esac
