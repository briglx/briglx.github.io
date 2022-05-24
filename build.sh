#!/bin/bash

bundle exec jekyll build 
touch ../docs/.nojekyll
rm ../docs/jasper2.gemspec