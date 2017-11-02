
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import showRegisterationForm from './showRegisterationForm.js';
import registerUser from './registerUserForm.js';
import loginUser from './loginUserForm.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();

});

window.addEventListener('load', () => {

  showRegisterationForm();
  registerUser();
  loginUser();

});
