
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import showRegisterationForm from './showRegisterationForm.js';
import registerUser from './registerUserForm.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  showRegisterationForm();
  registerUser();

});
