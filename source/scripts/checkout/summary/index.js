
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import setShippingRate from './setShippingRate.js';
import removeLineItem from './removeLineItem.js';
import updateLineItem from './updateLineItem.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  setShippingRate();
  removeLineItem();
  updateLineItem();
  modifyFormValueForResize();

});
