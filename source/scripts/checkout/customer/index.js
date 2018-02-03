
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import formSubmit from './formSubmit.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  formSubmit();

});
