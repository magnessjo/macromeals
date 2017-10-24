
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import removeLineItem from './removeLineItem.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  removeLineItem();
  modifyFormValueForResize();

});
