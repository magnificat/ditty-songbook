const directoryRE = (dirname) => new RegExp(`(?:^|/)${ dirname }/`);

module.exports = {
  entry: './frontend/index.js',

  output: {
    path: './static',
    filename: 'scripts.js'
  },

  module: {
    loaders: [ {
      test: /\.elm$/,
      exclude: ['elm-stuff', 'node_modules'].map(directoryRE),
      loader: 'elm-webpack'
    } ],

    noParse: /\.elm$/,
  },
}
