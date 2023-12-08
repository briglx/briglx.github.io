#!/usr/bin/env bash
################################################################################
# Create a new post with the current date and the title provided as an argument
# Usage: ./create_new_post.sh "My new post"
#
# Parameters:
#   $1: The title of the post

# Stop on errors
set -e

# Globals
PROJ_ROOT_PATH=$(cd "$(dirname "$0")"/..; pwd)
current_date=$(date +"%Y-%m-%d")

# Parse arguments
title=$1
if [ -z "$title" ]; then
    echo "Please provide a title as an argument."
    exit 1
fi

# Sanitize title
# Remove special characters from the title, replace spaces with dashes, and convert to lowercase
sanitized_title_filename=$(echo "$title" |  tr ' ' '-' | tr -cd '[:alnum:]-_' | tr '[:upper:]' '[:lower:]')
sanitized_title_body=$(echo "$title" | tr -cd "[:alnum:] ,.!?()[]{}+-=_'")

filename="${PROJ_ROOT_PATH}/source/_posts/${current_date}-${sanitized_title_filename}.md"
touch "$filename"

# Add front matter
echo -e "---\nlayout: post\ncurrent: post\nnavigation: True\nclass: post-template\nsubclass: 'post'\nauthor: brig\ntitle: \"$sanitized_title_body\"\ndate: \"$current_date\"\ntags:\n  - \"blogging\"\n---\n\nDear world, ..." > "$filename"

echo "Created new post: $filename"
