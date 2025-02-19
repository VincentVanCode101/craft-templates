#!/usr/bin/env bash
set -euo pipefail

generate_project() {
    local PROJECT_NAME="$1"
    local U_ID GID
    U_ID=$(id -u)
    GID=$(id -g)

    local DOCKERFILE="build.Dockerfile"
    local DOCKER_IMAGE_NAME="symfony-project-generator"

    docker build \
        -f "$DOCKERFILE" \
        --build-arg UID="$U_ID" \
        --build-arg GID="$GID" \
        --build-arg PROJECT_NAME="$PROJECT_NAME" \
        -t "$DOCKER_IMAGE_NAME" .

    docker run --rm \
        -v "$(pwd):/workspace" \
        "$DOCKER_IMAGE_NAME" \
        /bin/bash -c "cp -p -r /build-space/* /workspace"
    # /bin/bash -c "cp -p -r /build-space/* /workspace"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script is meant to be sourced, not executed directly." >&2
    exit 1
fi
