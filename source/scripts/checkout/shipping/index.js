
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import selectOption from './selectOption.js';
import calendar from './calendar.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  selectOption();
  calendar();

});
