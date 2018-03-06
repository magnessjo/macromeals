
const path = require( 'path' );
const webpack = require( 'webpack' );
const CopyWebpackPlugin = require( 'copy-webpack-plugin' );
const ExtractTextPlugin = require( 'extract-text-webpack-plugin' );
const ImageminPlugin = require( 'imagemin-webpack-plugin' ).default;
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

module.exports = {

  entry: {
    common: path.resolve(`source/scripts/common/`),
    homepage: path.resolve(`source/scripts/homepage`),
    about: path.resolve(`source/scripts/pages/about`),
    faq: path.resolve(`source/scripts/pages/faq`),
    contact: path.resolve(`source/scripts/pages/contact`),
    why: path.resolve(`source/scripts/pages/why`),
    shippingInstructions: path.resolve('source/scripts/pages/shipping-instructions'),
    shopdetails: path.resolve(`source/scripts/shop/details`),
    order: path.resolve(`source/scripts/shop/order`),
    meals: path.resolve(`source/scripts/shop/meals`),
    automation: path.resolve(`source/scripts/automation`),
    customer: path.resolve(`source/scripts/checkout/customer`),
    pickup: path.resolve(`source/scripts/checkout/pickup`),
    summary: path.resolve(`source/scripts/checkout/summary`),
    billing: path.resolve(`source/scripts/checkout/billing`),
    cart: path.resolve(`source/scripts/checkout/cart`),
    complete: path.resolve(`source/scripts/checkout/complete`),
    register: path.resolve(`source/scripts/account/register`),
    homepageStyle: path.resolve('source/styles/pages/homepage.css'),
    macrosStyle: path.resolve('source/styles/pages/macros.css'),
    aboutStyle: path.resolve('source/styles/pages/about.css'),
    genericStyle: path.resolve('source/styles/pages/generic.css'),
    faqStyle: path.resolve('source/styles/pages/faq.css'),
    whyStyle: path.resolve('source/styles/pages/why.css'),
    contactStyle: path.resolve('source/styles/pages/contact.css'),
    shippingInstructionsStyle: path.resolve('source/styles/pages/shipping-instructions.css'),
    shopdetailsStyle: path.resolve('source/styles/shop/shopDetails.css'),
    orderStyle: path.resolve('source/styles/shop/order.css'),
    mealsStyle: path.resolve('source/styles/shop/index.css'),
    checkoutStyle: path.resolve('source/styles/checkout/index.css'),
    labelsStyle: path.resolve('source/styles/automation/labels.css'),
    automationStyle: path.resolve('source/styles/automation/index.css'),
    automationSummaryStyle: path.resolve(`source/styles/automation/summary.css`),
    accountStyle: path.resolve('source/styles/account/index.css'),
  },

  output: {
    path: path.resolve('build'),
    filename: '[name].js',
  },

  devtool: 'none',

  stats: {
    assets: false,
    cached: false,
    cachedAssets: false,
    children: false,
    chunks: false,
    chunkModules: false,
    chunkOrigins: false,
    colors: true,
    errors: true,
    errorDetails: true,
    source: true,
    timings: true,
    warnings: true,
  },

  module: {
    rules: [
      {
        test: /\.jsx?$/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [ 'env' ]
          }
        }
      },
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [{ loader: 'css-loader', options: { importLoaders: 2,  minimize: true } },
            'postcss-loader'
          ]
        })
      }
    ],
  },

  plugins: [
    new CopyWebpackPlugin([
      { from: 'fonts/**/*', to: '', context: 'source/assets/'},
      { from: 'images/**/*', to: '', context: 'source/assets/' },
      { from: 'uploads/**/*', to: '', context: 'source/assets/'},
      { from: 'source/assets/craft/**/*', to: '', flatten: true },
    ]),
    new ExtractTextPlugin( '[name].css' ),
    new UglifyJsPlugin({
      test: /\.js($|\?)/i
    })
  ],

  resolve: {
    modules: [path.resolve('source'), path.resolve('node_modules')],
  }

};
