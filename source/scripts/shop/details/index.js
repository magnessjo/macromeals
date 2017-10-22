
import productCalculation from 'scripts/helpers/form/productCalculation.js';
import pieChart from 'scripts/components/pieChart.js';
import fixedForm from './fixedForm.js';
import factTab from './fact-tab.js';

// Load

window.addEventListener('load', () => {

  productCalculation();
  pieChart();
  fixedForm();
  factTab();

});
