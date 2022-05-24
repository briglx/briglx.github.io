# Blog Notes
Export content

Build Locally:

```bash
cd docs
bundle install
bundle exec jekyll serve
```

# Blog Migration

The goal is to move from Wordpress to GitHub pages.

* Export Wordpress Data
* Use `wordpress-export-to-markdown` tool to convert
* Use `Jasper2` theme

The migration isn't perfect. There are several issues between coversion and implementing Jasper2 theme.

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

# Building Site

Jekyll uses the files in `/source` and outputs to `/site-pages`. GitHub points to this folder to serve the site.

I can't use GitHub action to build until I can resolve the `tags` issue for #16.

In the meantime just build and deploy:

```bash

# Github uses this image https://github.com/actions/virtual-environments/blob/ubuntu20/20220515.1/images/linux/Ubuntu2004-Readme.md
# ruby --version 2.7.0.p0
# RubyGems 3.1.2
# https://github.com/actions/jekyll-build-pages
# image: 'docker://ghcr.io/actions/jekyll-build-pages:v1.0.3'
# https://github.com/actions/jekyll-build-pages/blob/main/Dockerfile
# ARG RUBY_VERSION=2.7.4
# FROM ruby:$RUBY_VERSION-slim#


cd /path/to/project/source
bundle exec jekyll build 


#
```

# Theme Ideas
- See https://dribbble.com/shots/18046803-Blogging-App-Design/attachments/13234820?mode=media

# References
- Building Locally https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll
- Minimal Mistakes A Jekyll theme https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/
