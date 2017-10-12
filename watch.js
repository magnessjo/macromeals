
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
      checkout: 'source/styles/pages/checkout/index.css',
      labels: 'source/styles/pages/labels.css',
      quickorder: 'source/styles/pages/quick-order.css',
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
      shopdetails: `source/scripts/shop/details`,
      labels: `source/scripts/labels`,
      quickOrder: `source/scripts/quickOrder`,
      customer: `source/scripts/checkout/customer`,
      summary: `source/scripts/checkout/summary`,
      billing: `source/scripts/checkout/billing`,
      process: `source/scripts/checkout/process`,
      user: `source/scripts/checkout/user`,
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
