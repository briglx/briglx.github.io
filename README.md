
# Blog Migration

The goal is to move from Wordpress to GitHub pages.

* Export Wordpress Data
* Use `wordpress-export-to-markdown` tool to convert
* Use `Jasper2` theme

The migration isn't perfect. There are several issues between conversion and implementing Jasper2 theme.

## Convert Wordpress to Markdown

The main issues are around code blocks. The tool doesn't seem to use markdown codeblocks.

Replace Cover Image. Replace `coverImage: "example.jpg"` with `cover: assets/images/example.jpg`

## Implementing Jasper2

One issue is the nav bar on non-home pages doesn't show.

Need to use ruby and node

```bash
bundle install
ruby --version
nvm install node
nvm install --lts

nvm alias default v16.15.0

node --version
v16.15.0

npm install
gulp
```

**Convert to Gulp 4**
There is a [known issue](https://stackoverflow.com/questions/55921442/how-to-fix-referenceerror-primordials-is-not-defined-in-node-js/60921145#60921145) between node 12 and gulp 3

Followed [migration instructions](https://www.sitepoint.com/how-to-migrate-to-gulp-4/)


**Replace special Chars**
The import applied a `\` to some special characters like `\=`

The full list was:
```
\_ \[ \] \\ \> \= \# \- \* \" \tick \* \.
```

I use the following regex to find where they might be
`\\[^A-Za-z0-9]+`

**Install MathJax**
Some of my post use LaTex so I need to render it.
MathJax is a JavaScript library that allows this

```bash
git clone https://github.com/mathjax/MathJax.git mj-tmp
mv mj-tmp/es5 <path-to-server-location>/mathjax
rm -rf mj-tmp
```

**GitHub Action**

The Jasper2 solution uses `helaili/jekyll-action@v2` to build and deploy the site.

`limjh16/jekyll-action-ts` is a port of that to TypeScript and does the following:

```bash
# Run "bundle install" locally and commit changes
bundle config set deployment true
bundle config path ${process.env.GITHUB_WORKSPACE}/vendor/bundle
bundle install --jobs=4 --retry=3 --gemfile=${gemSrc}

# Build Jekyll
bundle exec jekyll build -s ${jekyllSrc} ${INPUT_CUSTOM_OPTS}

# Format output html files
# options=[{"parser": "html"},{"plugins": ["parserHTML", "parserCSS", "parserJS"]}]
# prettier.format(filename, options)
```

**Building Jekyll Sites**

Jekyll uses the files in `/source` and outputs to `/site-pages`. GitHub points to this folder to serve the site.

I can't use GitHub action to build until I can resolve the `tags` issue for #16.

In the meantime just build and deploy outlined in [Deployment Tips](#deployment-tips).

```bash
# Github uses this image https://github.com/actions/virtual-environments/blob/ubuntu20/20220515.1/images/linux/Ubuntu2004-Readme.md
# ruby --version 2.7.0.p0
# RubyGems 3.1.2
# https://github.com/actions/jekyll-build-pages
# image: 'docker://ghcr.io/actions/jekyll-build-pages:v1.0.3'
# https://github.com/actions/jekyll-build-pages/blob/main/Dockerfile
# ARG RUBY_VERSION=2.7.4
# FROM ruby:$RUBY_VERSION-slim#

# Check OS Version
cat /etc/os-release
# PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
# The docker image runs
ruby -v
# ruby 2.7.4p191 (2021-07-07 revision a21a3b7d23) [x86_64-linux]
gem -v
# 3.1.6
gcc -v
# gcc version 10.2.1 20210110 (Debian 10.2.1-6)
g++ -v
# gcc version 10.2.1 20210110 (Debian 10.2.1-6)
make -v
# GNU Make 4.3
jekyll --version
# jekyll 3.9.0
bundler --version
# Bundler version 2.1.4
npm --version
# 6.14.18
node --version
# v14.21.3
gulp --version
# CLI version: 2.3.0
# # Build the image
# docker build --pull --rm -f "Dockerfile.build" -t blog_build:latest "."

# # Run the server
# docker run --rm -it --env-file .env -v /source:/usr/src/app/source -v /docs:/usr/src/app/docs --name blog_build blog_build:latest
# docker run --rm -it --env-file .env --mount type=bind,src="$(pwd)/docs",target=/usr/src/app/docs --mount type=bind,src="$(pwd)/source",target=/usr/src/app/source --name blog_build blog_build:latest

# Migrate Database
# docker container exec -it --env-file .env blog_build /usr/src/app/migrate_database.sh

# Build image
# docker build --pull --rm -f "Dockerfile.build" -t blog_build:latest "."

# Run Image
# docker run --rm -it --env-file .env -p 4000:4000 --mount type=bind,src="$(pwd)/docs",target=/usr/src/app/docs --mount type=bind,src="$(pwd)/source",target=/usr/src/app/source blog_build:latest
# # Generate site
# > jekyll build
# # Run site to test
# > jekyll serve -H 172.17.0.2

# # Or Run Image
# docker run --rm -it --env-file .env -p 0.0.0.0:4000:4000 --mount type=bind,src="$(pwd)/docs",target=/usr/src/app/docs --mount type=bind,src="$(pwd)/source",target=/usr/src/app/source blog_build:latest
# # Generate site
# > jekyll build
# # Run site to test
# > jekyll serve -H 0.0.0.0 -P 4000
```

# Theme Ideas
- See https://dribbble.com/shots/18046803-Blogging-App-Design/attachments/13234820?mode=media

# Development

You'll need to set up a development environment if you want to develop a new feature or add new posts.

## Setup your dev environment

Configure the environment variables. Copy example.env to .env and update the values

```bash
# load .env vars (optional)
[ -f .env ] && while IFS= read -r line; do [[ $line =~ ^[^#]*= ]] && eval "export $line"; done < .env
```

Setup Python Requirements

```bash
# Windows
# virtualenv \path\to\.venv -p path\to\specific_version_python.exe
# C:\Users\!Admin\AppData\Local\Programs\Python\Python310\python.exe -m venv .venv
# .venv\scripts\activate

# Linux
# virtualenv .venv /usr/local/bin/python3.10
# python3.10 -m venv .venv
# python3 -m venv .venv
python3 -m venv .venv
source .venv/bin/activate
# deactivate

# Update pip
python -m pip install --upgrade pip
pip install -r requirements_dev.txt
```

Configure linting and formatting tools

```bash
# Install tools
sudo apt-get update
sudo apt-get install -y shellcheck jq unzip zip
pre-commit install
```

Run the Site

```bash
# Build
./script/devops.sh build

# Serve local
./script/devops.sh serve
```
Browse to the sample application at http://localhost:4000 in a web browser.

## Testing

Ideally, all code is checked to verify the following:

All the unit tests pass
All code passes the checks from the linting tools
To run the linters, run the following commands:

```bash
# Use pre-commit scripts to run all linting
pre-commit run --all-files

# Run a specific linter via pre-commit
pre-commit run --all-files codespell

# Check for scripting errors
shellcheck *.sh

# Check for window line endings
find **/ -not -type d -exec file "{}" ";" | grep CRLF
# Fix with any issues with:
# sed -i.bak 's/\r$//' ./path/to/file
# Or Remove them
# find . -name "*.Identifier" -exec rm "{}" \;

# Run linters directly
codespell -D - -D .codespell_dict
shellcheck *.sh
```

## Deployment Tips

Here are the steps to modify, build, and commit new changes:

- From your repo's main branch, get the latest changes:
```bash
git pull
```
- Make your changes, create a post, or fix issues.
- Test your changes and check for style violations. <br> Consider adding tests to ensure that your code works.
- If everything looks good, build the site and commit your changes:
```bash
# Build the site if running outside of devcontainer
./script/devops_docker.sh build

# Build the site if running inside of devcontainer
./script/devops.sh build

# Commit changes to git
git add docs/*
git add <any additional files needed>
git checkout docs/.nojekyll
git commit -m "..."
```
  - Write a meaningful commit message and not only something like `Update` or `Fix`.
  - Use a capital letter to start with your commit message and do not finish with a full-stop (period).
  - Write your commit message using the imperative voice, e.g. `Add some feature` not `Adds some feature`.
- Push your committed changes back to GitHub:
```bash
git push origin HEAD
  ```

# References
- Building Locally https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll
- Minimal Mistakes A Jekyll theme https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/
