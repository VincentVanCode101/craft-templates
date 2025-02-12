#!/usr/bin/env bash
set -euo pipefail

generate_project() {
    PROJECT_NAME="$1"
    GROUP_ID="com.main"
    DOCKER_IMAGE_NAME="maven-project-generator"
    DOCKERFILE="build.Dockerfile"

    U_ID=$(id -u)
    G_ID=$(id -g)

    docker build \
        -f "$DOCKERFILE" \
        --build-arg UID="$U_ID" \
        --build-arg G_ID="$G_ID" \
        --build-arg GROUP_ID="$GROUP_ID" \
        --build-arg ARTIFACT_ID="$PROJECT_NAME" \
        -t "$DOCKER_IMAGE_NAME" .

    docker run --rm \
        -v "$(pwd):/workspace" \
        "$DOCKER_IMAGE_NAME" \
        /bin/bash -c "cp -p -r /build-space/* /workspace"

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script is meant to be sourced, not executed directly." >&2
    exit 1
fi
