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

# Theme Ideas
- See https://dribbble.com/shots/18046803-Blogging-App-Design/attachments/13234820?mode=media

# References
- Building Locally https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll
