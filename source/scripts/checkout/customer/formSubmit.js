
// Import

import scrollToLocation from 'scripts/helpers/scrollToLocation.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';

// Variables

const form = document.querySelector('form');
// const billingContainer = document.querySelector('#billing-address');
// const checkbox = billingContainer.querySelector('input[type="checkbox"]');
const requiredFields = Array.from(form.querySelectorAll('[data-required]'));
// const billingRequiredFields = Array.from(billingContainer.querySelectorAll('[data-required]'));
const inputs = Array.from(form.querySelectorAll('inputs[type="text"]'));

// Export

export default function() {

  form.addEventListener('submit', (e) => {

    e.preventDefault();

    let shouldScroll = true;
    let fields = requiredFields;

    // if (checkbox.checked) {
    //
    //   billingRequiredFields.forEach((field) => {
    //
    //     const index = requiredFields.indexOf(field);
    //     fields.splice(index, 1);
    //
    //   });
    //
    // }

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
