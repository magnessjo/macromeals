
// Imports

import modifyFormValueForResize from 'scripts/helpers/form/modifyFormValueForResize.js';
import registerCTA from './registerButton.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  modifyFormValueForResize();
  registerCTA();

});
