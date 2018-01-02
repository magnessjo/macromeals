
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import submitStripe from './stripe.js';
import dPayment from './dPayment.js';
import paymentRequestApi from './paymentRequestApi.js';
import switchPaymentMethod from './switchPaymentMethod.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  switchPaymentMethod();
  submitStripe();
  dPayment();
  paymentRequestApi();

});
