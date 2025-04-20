#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

PROJECT_NAME="$1"

echo "Step 1: Cleaning up build files..."
rm -f create.sh

echo "Project setup complete!"
