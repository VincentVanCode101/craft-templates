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

# echo "Step 3: Moving project files up one level..."
# source ./move_files.sh
# move_project_files "$PROJECT_NAME"

echo "Step 4: Replacing project name placeholders..."
source ./rename_project.sh
rename_project "$PROJECT_NAME"

# echo "Step 6: Cleaning up build files..."
# rm -f generate_project.sh move_files.sh rename_project.sh create.sh replace_in_file.sh partialREADME.md build.Dockerfile

echo "Project setup complete!"
