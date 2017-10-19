
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import formValidation from './formValidation.js';
import billingForm from './billingForm.js';
import formSubmit from './formSubmit.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  formValidation();
  billingForm();
  formSubmit();

});
