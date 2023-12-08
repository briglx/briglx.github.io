#!/usr/bin/env bash
######################################################
# Build jekyle site.
# Globals:
#
# Params
#   COMMAND: build or serve
######################################################
echo starting script - devops.sh

# Stop on errors
set -e

## Globals
PROJ_ROOT_PATH=$(cd "$(dirname "$0")"/..; pwd)
echo "Project root: $PROJ_ROOT_PATH"

# Print dependency versions
"${PROJ_ROOT_PATH}/script/validate_dependencies.sh"

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

action="${1:-build}"

echo
echo
pwd
ls -al
echo ls "${PROJ_ROOT_PATH}/source"
echo

case "$action" in
  build)
    # Add build logic here
    echo "Running build..."
    # Rebuild css
    echo cd "${PROJ_ROOT_PATH}/source"
    cd "${PROJ_ROOT_PATH}/source"
    npm install
    gulp build

    # build site
    bundle install
    bundle exec jekyll build
    # Tell github not to create site
    touch "${PROJ_ROOT_PATH}/_site/.nojekyll"

    # Remove gemspec
    rm "${PROJ_ROOT_PATH}/_site/jasper2.gemspec"
    ;;
  serve)
    # Add serve logic here
    echo "Running serve..."
    # Rebuild css
    cd "${PROJ_ROOT_PATH}/source"
    npm install
    gulp build

    # build site
    bundle install
    bundle exec jekyll serve
    # Tell github not to create site
    touch "${PROJ_ROOT_PATH}/_site/.nojekyll"

    # Remove gemspec
    rm "${PROJ_ROOT_PATH}/_site/jasper2.gemspec"
    ;;
  *)
    echo "Invalid action: $action. Available actions: build, serve"
    ;;
esac
