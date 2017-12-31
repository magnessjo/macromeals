
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import submitStripe from './submitStripe.js';
import dPayment from './dPayment.js';
import switchPaymentMethod from './switchPaymentMethod.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  switchPaymentMethod();
  submitStripe();
  dPayment();

});
