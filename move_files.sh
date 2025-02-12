#!/usr/bin/env bash
set -euo pipefail

move_project_files() {
    if [ -z "${1:-}" ]; then
        echo "Usage: move_project_files <PROJECT_NAME>" >&2
        return 1
    fi

    local PROJECT_NAME="$1"

    if [ ! -d "$PROJECT_NAME" ]; then
        echo "Error: Project folder '$PROJECT_NAME' not found." >&2
        return 1
    fi

    mv "$PROJECT_NAME"/* .
    rm -rf "$PROJECT_NAME"
    echo "Project files moved successfully."
}

# Prevent direct execution of this script.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script is meant to be sourced, not executed directly." >&2
    exit 1
fi
