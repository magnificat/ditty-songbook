const directoryRE = (dirname) => new RegExp(`(?:^|/)${ dirname }/`);

module.exports = {
  entry: './source/index.js',

  output: {
    filename: 'bundle.js'
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
