#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

echo "Project setup complete!"
