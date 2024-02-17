#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT=$(git rev-parse --show-toplevel)
mkdir -p "${PROJECT_ROOT}/docker/build"

DOCKER_BUILD_DIR="${PROJECT_ROOT}/docker/build"
BUILD_DIR="${PROJECT_ROOT}/cmake-build-debug"

# Create Docker build directory
rm -rf "${DOCKER_BUILD_DIR}" && mkdir "${DOCKER_BUILD_DIR}"
cp "${PROJECT_ROOT}/docker/Dockerfile" "${DOCKER_BUILD_DIR}/Dockerfile"
cp "${BUILD_DIR}/application/application" "${DOCKER_BUILD_DIR}/tabetai2-server"

(cd "${DOCKER_BUILD_DIR}" && docker build -t tabetai2-server:latest .)
