
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';
import formSubmit from './formSubmit.js';

// Variables

const form = document.querySelector('form');

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  // displayBillingForm();
  inputQuery(form);
  formSubmit();

});
