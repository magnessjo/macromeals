
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import validateForm from './validateForm.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  validateForm();

});
