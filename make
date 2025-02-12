#!/usr/bin/env bash
# Bash script for Quarkus Project

# Variable
MVNW="mvn"

# Function to display help
display_help() {
    echo "Available commands:"
    echo "  build        - Build the application (creates an executable JAR)"
    echo "  dev          - Run the application in development mode"
    echo "  test         - Run tests"
    echo "  package      - Package the application"
}

# If no arguments are provided, display help and exit
if [ "$#" -eq 0 ]; then
    display_help
    exit 0
fi

# Process command-line arguments
case "$1" in
build)
    $MVNW package
    ;;
dev)
    $MVNW quarkus:dev
    ;;
test)
    $MVNW test
    ;;
package)
    $MVNW package -Dquarkus.package.jar.type=uber-jar
    ;;
help)
    display_help
    ;;
*)
    echo "Invalid command: $1"
    display_help
    exit 1
    ;;
esac
