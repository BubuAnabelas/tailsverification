module.exports = {
  mode: 'production',
  entry: './CryptoUtils.js',
  output: {
    library: 'CryptoUtils',
    libraryExport: 'default',
    filename: 'bundle.js',
    path: __dirname + '/build'
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [['@babel/preset-env', {"targets": { "browsers": ["last 1 years and >1%"]}} ]]
          }
        }
      }
    ]
  },
  optimization: {
    usedExports: true,
    minimize: true,
  }
};