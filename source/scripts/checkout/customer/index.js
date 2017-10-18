
// Imports

import formValue from '../components/formValue';
import formValidation from './formValidation.js';
import billingForm from './billingForm.js';
import formSubmit from './formSubmit.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  formValue();
  formValidation();
  billingForm();
  formSubmit();

});
