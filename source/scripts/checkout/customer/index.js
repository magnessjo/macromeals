
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import inputListenerEvents from 'scripts/helpers/form/inputListenerEvents.js';
import displayBillingForm from './displayBillingForm.js';
import formSubmit from './formSubmit.js';

// Variables

const form = document.querySelector('form');

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  displayBillingForm();
  inputListenerEvents(form);
  formSubmit();

});
