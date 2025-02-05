#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

PROJECT_NAME="$1"
GROUP_ID="com.main"
DOCKER_IMAGE_NAME="maven-project-generator"
DOCKERFILE="build.Dockerfile"

# Get user and group IDs
U_ID=$(id -u)
G_ID=$(id -g)

# Build the Docker image
docker build \
    -f "$DOCKERFILE" \
    --build-arg UID="$U_ID" \
    --build-arg G_ID="$G_ID" \
    --build-arg GROUP_ID="$GROUP_ID" \
    --build-arg ARTIFACT_ID="$PROJECT_NAME" \
    -t "$DOCKER_IMAGE_NAME" .

# Run the container and copy the generated project files to workspace
docker run --rm \
    -v "$(pwd):/workspace" \
    "$DOCKER_IMAGE_NAME" \
    /bin/bash -c "cp -p -r /build-space/* /workspace"
