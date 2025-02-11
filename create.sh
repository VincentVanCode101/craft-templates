#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

PROJECT_NAME="$1"

echo "Step 1: Generating project..."
bash generate_project.sh "$PROJECT_NAME"

echo "Step 2: Moving project files up one level..."
bash move_files.sh "$PROJECT_NAME"

echo "Step 3: Replacing project name placeholders..."
bash rename_project.sh "$PROJECT_NAME"

echo "Step 4: Cleaning up temporary scripts..."
rm -f generate_project.sh move_files.sh rename_project.sh create.sh

echo "Project setup complete!"
