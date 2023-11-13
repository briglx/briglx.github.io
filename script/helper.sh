#!/usr/bin/env bash
######################################################
# Helper script to build and run jekyle site
# Globals:
#
# Params
#   COMMAND: build or serve
######################################################
echo starting script

# Stop on errors
set -e

## Globals
PROJ_ROOT_PATH=$(cd "$(dirname "$0")"/..; pwd)
echo "Project root: $PROJ_ROOT_PATH"

action="${1:-build}"

# Build docker image
docker build --pull --rm -f "${PROJ_ROOT_PATH}/Dockerfile.build" -t blog_build:latest "."

case "$action" in
  build)
    # Add build logic here
    echo "Running build..."
    # Execute the build script
    docker run --rm -it --env-file .env -p 4000:4000 --mount type=bind,src="${PROJ_ROOT_PATH}/docs",target=/usr/src/app/docs --mount type=bind,src="${PROJ_ROOT_PATH}/source",target=/usr/src/app/source blog_build:latest build
    ;;
  serve)
    # Add serve logic here
    echo "Running serve..."
    # Execute the serve script
    docker run --rm -it --env-file .env -p 4000:4000 --mount type=bind,src="${PROJ_ROOT_PATH}/docs",target=/usr/src/app/docs --mount type=bind,src="${PROJ_ROOT_PATH}/source",target=/usr/src/app/source blog_build:latest serve
    ;;
  *)
    echo "Invalid action: $action. Available actions: build, serve"
    ;;
esac
