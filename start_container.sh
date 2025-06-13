#!/bin/bash

set -e

args="-f docker_compose.yml up -d"

# Check if podman-compose is installed
if ! command -v podman-compose &> /dev/null; then
    echo "podman-compose not found. Installing..."
    if ! command -v pip &> /dev/null; then
        echo "pip not found. Please install Python and pip first."
        exit 1
    fi
    pip install podman-compose
fi

# Check if podman is installed
if ! command -v podman &> /dev/null; then
    echo "podman not found. Please install podman first."
    exit 1
fi

# Set podman socket configuration for rootless mode if needed
if [ -S "/run/user/$UID/podman/podman.sock" ]; then
    export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
fi

echo "Starting test container"
podman-compose -f docker_compose.yml up -d
