
// Imports

import pieChart from 'scripts/components/pieChart.js';
import shipping from 'scripts/components/shipping.js';
import switchImages from './switch-images.js';

// Load

window.addEventListener('load', () => {

  switchImages();
  shipping();
  pieChart();

});
