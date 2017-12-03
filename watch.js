
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
      about: 'source/styles/pages/about.css',
      generic: 'source/styles/pages/generic.css',
      faq: 'source/styles/pages/faq.css',
      shopdetails: 'source/styles/shop/shopDetails.css',
      quickorder: 'source/styles/shop/quick-order.css',
      checkout: 'source/styles/checkout/index.css',
      labels: 'source/styles/automation/labels.css',
      automation: 'source/styles/automation/index.css',
      account: 'source/styles/account/index.css',
    },
  },

  scripts: {
    paths: [`source/scripts/**/*.js`],
    task: builder.scripts,
    files: {
      common: `source/scripts/common/`,
      homepage: `source/scripts/homepage`,
      about: `source/scripts/pages/about`,
      faq: `source/scripts/pages/faq`,
      shopdetails: `source/scripts/shop/details`,
      quickorder: `source/scripts/shop/quickOrder`,
      automation: `source/scripts/automation`,
      customer: `source/scripts/checkout/customer`,
      shipping: `source/scripts/checkout/shipping`,
      summary: `source/scripts/checkout/summary`,
      billing: `source/scripts/checkout/billing`,
      cart: `source/scripts/checkout/cart`,
      register: `source/scripts/account/register`,
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
