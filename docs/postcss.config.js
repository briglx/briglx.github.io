module.exports = {
  plugins: [
    require('postcss-easy-import'),
    require('postcss-custom-properties'),
    require('postcss-color-function'),
    require('autoprefixer'),
    require('cssnano')
  ]
}