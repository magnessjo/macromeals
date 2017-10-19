
// Imports

import notice from 'scripts/components/notice.js';
import pieChart from 'scripts/components/pieChart.js';
import shipping from 'scripts/components/shipping.js';
import switchImages from './switch-images.js';

// Load

window.addEventListener('load', () => {

  notice();
  switchImages();
  shipping();
  pieChart();

});
