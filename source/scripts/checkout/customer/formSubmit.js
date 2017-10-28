
// Import

import scrollToLocation from 'scripts/helpers/scrollToLocation.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';

// Variables

const form = document.querySelector('form');
const requiredFields = Array.from(form.querySelectorAll('[data-required]'));
const inputs = Array.from(form.querySelectorAll('inputs[type="text"]'));

// Export

export default function() {

  form.addEventListener('submit', (e) => {

    e.preventDefault();

    let shouldScroll = true;
    let fields = requiredFields;

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
