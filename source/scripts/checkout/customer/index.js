
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import formSubmit from './formSubmit.js';
import notice from 'scripts/components/notice.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  formSubmit();
  notice();

});
