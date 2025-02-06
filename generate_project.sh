#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

PROJECT_NAME="$1"
DOCKERFILE="build.Dockerfile"
DOCKER_IMAGE_NAME="rust-project-generator"

U_ID=$(id -u)
G_ID=$(id -g)

docker build \
    -f $DOCKERFILE \
    --build-arg UID=$U_ID \
    --build-arg GID=$G_ID \
    --build-arg PROJECT_NAME=$PROJECT_NAME \
    -t $DOCKER_IMAGE_NAME .

docker run --rm \
    -v "$(pwd):/workspace" \
    $DOCKER_IMAGE_NAME \
    /bin/sh -c "cp -p -r /build-space/* /workspace"

echo "Cleaning up: Removing build.Dockerfile..."
rm -f "$DOCKERFILE"
