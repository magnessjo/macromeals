
// Import

import productCalculation from 'scripts/helpers/form/productCalculation.js';
import fixedElement from 'scripts/helpers/fixedElement.js';
import notice from 'scripts/components/notice.js';
import productList from 'scripts/helpers/form/productList.js';

// Variables

const container = document.querySelector('.summary');
const element = container.querySelector('.fixed-wrapper');

// Load

document.addEventListener('DOMContentLoaded', () => {

  fixedElement(container, element);
  productCalculation();
  notice();
  productList();

});
