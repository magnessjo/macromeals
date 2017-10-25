
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import removeLineItem from './removeLineItem.js';
import updateLineItem from './updateLineItem.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  removeLineItem();
  updateLineItem();
  modifyFormValueForResize();

});
