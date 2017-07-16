const webpack = require('webpack')

module.exports = {
  entry: './app/javascript/blacklight/index.js',
  output: {
    filename: './app/assets/javascripts/blacklight/blacklight.js'
  },
  target: 'node',
  externals: {
    'jquery': 'jQuery',
    'bootstrap': 'bootstrap',
    //'typeahead': 'typeahead',
    //'bloodhound': 'bloodhound'
  },
  plugins: [
    new webpack.ProvidePlugin({
      jQuery: 'jquery',
      $: 'jquery',
      jquery: 'jquery'
    })
  ]
}
