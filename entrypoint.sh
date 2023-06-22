#!/bin/bash

#######################################################################################################
#
# Build the site using whitelisted plugins and supported configuration
#
#######################################################################################################

set -o errexit

# SOURCE_DIRECTORY=${GITHUB_WORKSPACE}/$INPUT_SOURCE
# DESTINATION_DIRECTORY=${GITHUB_WORKSPACE}/$INPUT_DESTINATION
# PAGES_GEM_HOME=$BUNDLE_APP_CONFIG
# GITHUB_PAGES=$PAGES_GEM_HOME/bin/github-pages

# # Set environment variables required by supported plugins
# export JEKYLL_ENV="production"
# export JEKYLL_GITHUB_TOKEN=$INPUT_TOKEN
# export PAGES_REPO_NWO=$GITHUB_REPOSITORY
# export JEKYLL_BUILD_REVISION=$INPUT_BUILD_REVISION

# # Set verbose flag
# if [ "$INPUT_VERBOSE" = 'true' ]; then
#   VERBOSE='--verbose'
# else
#   VERBOSE=''
# fi

# # Set future flag
# if [ "$INPUT_FUTURE" = 'true' ]; then
#   FUTURE='--future'
# else
#   FUTURE=''
# fi

# cd "$PAGES_GEM_HOME"
# $GITHUB_PAGES build "$VERBOSE" "$FUTURE" --source "$SOURCE_DIRECTORY" --destination "$DESTINATION_DIRECTORY"


#!/bin/bash

action="${1:-build}"

case "$action" in
  build)
    # Add build logic here
    echo "Running build..."
    # Rebuild css 
    cd source
    npm install
    gulp build

    # build site
    bundle install 
    bundle exec jekyll build 
    # Tell github not to create site
    touch ../docs/.nojekyll

    # Remove gemspec
    rm ../docs/jasper2.gemspec
    ;;
  serve)
    # Add serve logic here
    echo "Running serve..."
    # Rebuild css 
    cd source
    npm install
    gulp build

    # build site
    bundle install 
    bundle exec jekyll serve -H 172.17.0.2 
    # Tell github not to create site
    touch ../docs/.nojekyll

    # Remove gemspec
    rm ../docs/jasper2.gemspec
    ;;
  *)
    echo "Invalid action: $action. Available actions: build, serve"
    ;;
esac




