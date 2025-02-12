#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <new_project_name>" >&2
    exit 1
fi

readonly PROJECT_NAME="$1"

source ./rename_project.sh

echo "Step 1: Replacing project name placeholders..."
rename_project "$PROJECT_NAME"

echo "Step 2: Cleaning up: Removing build files..."
rm -f rename_project.sh

echo "Project setup complete!"
