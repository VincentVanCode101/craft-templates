#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <new_project_name>" >&2
    exit 1
fi

readonly PROJECT_NAME="$1"

echo "Step 1: Replacing project name placeholders..."
bash rename_project.sh "$PROJECT_NAME"

echo "Cleaning up: Removing generate_project.sh..."
rm -f generate_project.sh

echo "Project setup complete!"
