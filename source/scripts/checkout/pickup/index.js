
// Imports

import calendar from 'scripts/helpers/calendar.js';
import selection from './selection.js';
import formSubmit from './formSubmit.js';
import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  calendar();
  selection();
  formSubmit();
  modifyFormValueForResize();

});
