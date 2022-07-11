#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT=$(git rev-parse --show-toplevel)
TABETAI2_FLUTTER_ROOT="${PROJECT_ROOT}/gui/tabetai2_flutter"
mkdir -p "${TABETAI2_FLUTTER_ROOT}/docker/build"

DOCKER_BUILD_DIR="${TABETAI2_FLUTTER_ROOT}/docker/build"
BUILD_DIR="${TABETAI2_FLUTTER_ROOT}/build"

# Create Docker build directory
rm -rf "${DOCKER_BUILD_DIR}" && mkdir "${DOCKER_BUILD_DIR}"
cp "${TABETAI2_FLUTTER_ROOT}/docker/Dockerfile" "${DOCKER_BUILD_DIR}/Dockerfile"

# Build web server
(cd "${TABETAI2_FLUTTER_ROOT}" && flutter build web)
cp -r "${BUILD_DIR}/web" "${DOCKER_BUILD_DIR}/web"

(cd "${DOCKER_BUILD_DIR}" && docker build -t tabetai2-web-server:latest .)
