
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import removeLineItem from 'scripts/helpers/cart/removeLineItem.js';
import updateLineItem from 'scripts/helpers/cart/updateLineItem.js';
import couponCode from './couponCode.js';
import coolerClub from './coolerClub.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  removeLineItem();
  updateLineItem();
  modifyFormValueForResize();
  couponCode();
  coolerClub();

});
