#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

PROJECT_NAME="$1"

if [ ! -d "$PROJECT_NAME" ]; then
    echo "Error: Project folder '$PROJECT_NAME' not found."
    exit 1
fi

mv "$PROJECT_NAME"/* .

rm -fr "$PROJECT_NAME"

echo "Project files moved successfully."
