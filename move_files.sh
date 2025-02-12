#!/usr/bin/env bash
set -euo pipefail

move_files() {
    local project_name="$1"

    if [ ! -d "$project_name" ]; then
        echo "Error: Project folder '$project_name' not found."
        exit 1
    fi

    mv "$project_name"/* .
    rm -fr "$project_name"

}

# Prevent direct execution of this script.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script is meant to be sourced, not executed directly." >&2
    exit 1
fi
