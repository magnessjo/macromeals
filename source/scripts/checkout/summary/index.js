
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import removeLineItem from './removeLineItem.js';
import updateLineItem from './updateLineItem.js';
import couponCode from './couponCode.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  removeLineItem();
  updateLineItem();
  modifyFormValueForResize();
  couponCode();

});
