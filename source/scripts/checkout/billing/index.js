
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import submitForm from './submitForm.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  submitForm();

});
