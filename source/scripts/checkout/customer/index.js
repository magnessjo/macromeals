
// Imports

import calendar from 'scripts/helpers/calendar.js';
import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import formSubmit from './formSubmit.js';
import setDeliveryDateOnLoad from './setDeliveryDateOnLoad.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  calendar();
  modifyFormValueForResize();
  formSubmit();
  setDeliveryDateOnLoad();

});
