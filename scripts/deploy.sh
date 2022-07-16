#!/usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY_HOST=${1?"Docker host must be set"}
DOCKER_REGISTRY_PORT=${2:-"5000"}

DOCKER_REGISTRY="${DOCKER_REGISTRY_HOST}:${DOCKER_REGISTRY_PORT}"
DOCKER_TAG="latest"

echo "Using ${DOCKER_REGISTRY} as Docker registry"

docker/build_all.sh

docker tag "tabetai2-server:${DOCKER_TAG}" "${DOCKER_REGISTRY}/tabetai2-server:${DOCKER_TAG}"
docker push "${DOCKER_REGISTRY}/tabetai2-server:${DOCKER_TAG}"
docker tag "tabetai2-web-server:${DOCKER_TAG}" "${DOCKER_REGISTRY}/tabetai2-web-server:${DOCKER_TAG}"
docker push "${DOCKER_REGISTRY}/tabetai2-web-server:${DOCKER_TAG}"
