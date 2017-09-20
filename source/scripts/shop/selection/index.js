
// Import

import notice from '../../components/notice.js';
import pieChart from '../../components/pieChart.js';
import filter from './filter.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  notice();
  filter();

});

window.addEventListener('load', () => {

  pieChart();

});
