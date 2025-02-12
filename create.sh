#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

PROJECT_NAME="$1"

source ./generate_project.sh
source ./move_files.sh
source ./rename_project.sh

echo "Step 1: Generating project..."
generate_project "$PROJECT_NAME"

echo "Step 2: Moving project files up one level..."
move_files "$PROJECT_NAME"

echo "Step 3: Replacing project name placeholders..."
rename_project "$PROJECT_NAME"

echo "Step 4: Cleaning up build files..."
rm -f generate_project.sh move_files.sh rename_project.sh create.sh build.Dockerfile

echo "Project setup complete!"
