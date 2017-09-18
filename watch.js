
// Watch

import gaze from 'gaze';
import path from 'path';
import builder from 'builder';

import {
  fork,
} from 'child_process';

const config = {

  assets: {
    paths: ['source/assets/**/*.*'],
    task: builder.assets,
    files: {
      assets: 'source/assets/*',
    },
  },

  styles: {
    paths: ['source/styles/**/*.css'],
    task: builder.styles,
    files: {
      homepage: 'source/styles/pages/homepage.css',
      macros: 'source/styles/pages/macros.css',
      generic: 'source/styles/pages/generic.css',
      faq: 'source/styles/pages/faq.css',
      shop: 'source/styles/pages/shop/shop.css',
      shopdetails: 'source/styles/pages/shop/shopDetails.css',
      cart: 'source/styles/pages/shop/cart.css',
      customer: 'source/styles/pages/shop/customer.css',
      billing: 'source/styles/pages/shop/billing.css',
      confirmation: 'source/styles/pages/shop/confirmation.css',
    },
  },

  scripts: {
    paths: [`source/scripts/**/*.js`],
    task: builder.scripts,
    files: {
      app: `source/scripts/app.js`,
      homepage: `source/scripts/homepage`,
      faq: `source/scripts/faq`,
      shopselection: `source/scripts/shop/selection`,
      cart: `source/scripts/shop/cart`,
    },
  },

};

// Configure Gaze

Object.keys(config).forEach(key => {

  config[key].task(config[key].files);

  const watch = function watcher(err, watcher) {
    this.on('all', (event, path) => config[key].task(config[key].files));
  };

  config[key].gaze = gaze(config[key].paths, watch);

});

// Close on SIGINT, SINGTERM, or exit

function kill() {

  Object.keys(config).forEach(key => config[key].gaze.close());
  process.exit();

}

process.on('SIGINT', kill);
process.on('SIGTERM', kill);
process.on('exit', kill);
