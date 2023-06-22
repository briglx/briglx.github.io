#!/bin/bash

action="${1:-build}"

docker build --pull --rm -f "Dockerfile.build" -t blog_build:latest "."

case "$action" in
  build)
    # Add build logic here
    echo "Running build..."
    # Execute the build script
    docker run --rm -it --env-file .env -p 4000:4000 --mount type=bind,src="$(pwd)/docs",target=/usr/src/app/docs --mount type=bind,src="$(pwd)/source",target=/usr/src/app/source blog_build:latest build
    ;;
  serve)
    # Add serve logic here
    echo "Running serve..."
    # Execute the serve script
    docker run --rm -it --env-file .env -p 4000:4000 --mount type=bind,src="$(pwd)/docs",target=/usr/src/app/docs --mount type=bind,src="$(pwd)/source",target=/usr/src/app/source blog_build:latest serve
    ;;
  *)
    echo "Invalid action: $action. Available actions: build, serve"
    ;;
esac

# Build site using docker image


