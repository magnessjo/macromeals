
// Imports

import productCalculation from 'scripts/helpers/form/productCalculation.js';
import pieChart from 'scripts/components/pieChart.js';
import fixedElement from 'scripts/helpers/fixedElement.js';
import fixedForm from './fixedForm.js';
import factTab from './fact-tab.js';

// Variables

const container = document.querySelector('.product-actions');
const element = container.querySelector('.fixed-wrapper');

// Load

window.addEventListener('load', () => {

  productCalculation();
  pieChart();
  fixedElement(container, element);
  factTab();

});
