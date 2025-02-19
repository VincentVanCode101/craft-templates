#!/usr/bin/env bash
set -euo pipefail

if [ -z "${1-}" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

PROJECT_NAME="$1"

echo "Step 1: Generating project..."
source ./generate_project.sh
generate_project "$PROJECT_NAME"

echo "Step 2: Replacing project name placeholders..."
source ./rename_project.sh
rename_project "$PROJECT_NAME"

echo "Step 3: Cleaning up build files..."
rm -f generate_project.sh rename_project.sh create.sh build.Dockerfile

echo "Project setup complete!"
