
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import submitStripe from './stripe.js';
import dPayment from './dPayment.js';
import paymentRequestApi from './paymentRequestApi.js';
import switchPaymentMethod from './switchPaymentMethod.js';

// Variables

const stripe = window.location.origin == 'https://www.macromeals.life' ? Stripe('pk_live_5eXACjQVrzeUQpCpF0ydV15h') : Stripe('pk_test_UrlLqyCEbnu4hXNhRRFaA16n');
const elements = stripe.elements();

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  switchPaymentMethod();
  submitStripe(stripe, elements);
  paymentRequestApi(stripe, elements);
  dPayment();

});
