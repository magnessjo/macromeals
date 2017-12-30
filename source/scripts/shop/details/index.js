
// Imports

import pieChart from 'scripts/components/pieChart.js';
import increment from './increment.js';
import inputEvents from './inputEvents.js';
import submitForm from './submitform.js';
import scrollToForm from './scrollToForm.js';

// Load

window.addEventListener('load', () => {

  pieChart();
  increment();
  inputEvents();
  submitForm();
  scrollToForm();

});
