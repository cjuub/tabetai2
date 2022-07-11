#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT=$(git rev-parse --show-toplevel)

"${PROJECT_ROOT}"/docker/build.sh
"${PROJECT_ROOT}"/gui/tabetai2_flutter/docker/build.sh
