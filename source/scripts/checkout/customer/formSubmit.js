
// Import

import scrollToLocation from 'scripts/helpers/scrollToLocation.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';
import checkSelectFields from 'scripts/helpers/form/checkSelectFields.js';

// Variables

const form = document.querySelector('form#address-info');
const requiredFields = Array.from(form.querySelectorAll('[data-required]'));
const inputs = Array.from(form.querySelectorAll('inputs[type="text"]'));
const selects = form.querySelectorAll('select');

// Export

export default function() {

  // Event Listeners For Inputs

  checkSelectFields(selects);
  inputQuery(form);

  // Form Submit

  form.addEventListener('submit', (e) => {

    e.preventDefault();

    let shouldScroll = true;
    let fields = requiredFields;

    checkSelectFields(selects, true);
    inputQuery(form, false);

    for (let i = 0; i < fields.length; i++) {

      const elm = fields[i];
      const isValid = elm.getAttribute('valid');

      if (isValid == 'false') {

        if (shouldScroll) {
          scrollToLocation(elm, 120);
          shouldScroll = false;
        }

        return;

      } else {

        if (i == fields.length - 1) {
          form.submit();
        }

      }

    }

  });

}
