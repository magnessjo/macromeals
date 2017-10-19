
// Import

import formValidation from './formValidation.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';

// Variables

const form = document.querySelector('form');
const billingContainer = document.querySelector('#billing-address');
const checkbox = billingContainer.querySelector('input[type="checkbox"]');
const requiredFields = Array.from(form.querySelectorAll('[data-required]'));
const billingRequiredFields = Array.from(billingContainer.querySelectorAll('[data-required]'));
const inputs = Array.from(form.querySelectorAll('inputs[type="text"]'));

// Export

export default function() {

  form.addEventListener('submit', (e) => {

    e.preventDefault();

    let validForm = false;
    let shouldScroll = true;
    let fields = requiredFields;

    if (checkbox.checked) {

      billingRequiredFields.forEach((field) => {

        const index = requiredFields.indexOf(field);
        fields.splice(index, 1);

      });

    }

    fields.forEach((elm, i) => {

      const isValid = elm.getAttribute('valid');

      if (isValid == 'false') {

        formValidation(true);

        if (shouldScroll) {
          scrollToLocation(elm, 120);
          shouldScroll = false;
        }

        if (i == fields.length - 1) validForm = true;

      } else {

        if (validForm) {
          form.submit();
        }

      }

    });



  });

}
