#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

PROJECT_NAME="$1"

source ./rename_project.sh

echo "Step 1: Replacing project name placeholders..."
rename_project "$PROJECT_NAME"

echo "Step 2: Cleaning up build files..."
rm -f rename_project.sh create.sh

echo "Project setup complete!"
