
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
      shop: 'source/styles/shop/shop.css',
      shopdetails: 'source/styles/shop/shopDetails.css',
      quickorder: 'source/styles/shop/quick-order.css',
      checkout: 'source/styles/checkout/index.css',
      labels: 'source/styles/automation/labels.css',
      account: 'source/styles/account/index.css',
    },
  },

  scripts: {
    paths: [`source/scripts/**/*.js`],
    task: builder.scripts,
    files: {
      common: `source/scripts/common/`,
      homepage: `source/scripts/pages/homepage`,
      faq: `source/scripts/pages/faq`,
      shopselection: `source/scripts/shop/selection`,
      shopdetails: `source/scripts/shop/details`,
      quickOrder: `source/scripts/shop/quickOrder`,
      automation: `source/scripts/automation`,
      customer: `source/scripts/checkout/customer`,
      summary: `source/scripts/checkout/summary`,
      billing: `source/scripts/checkout/billing`,
      process: `source/scripts/checkout/process`,
      login: `source/scripts/account/login`,
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
