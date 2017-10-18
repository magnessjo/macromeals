
// Import

import formValidation from './formValidation.js';

// Variables

const form = document.querySelector('form');
const billingContainer = document.querySelector('#billing-address');
const checkbox = billingContainer.querySelector('input[type="checkbox"]');
const requiredFields = Array.from(form.querySelectorAll('[data-required]'));
const billingRequiredFields = Array.from(billingContainer.querySelectorAll('[data-required]'));
const inputs = Array.from(form.querySelectorAll('inputs[type="text"]'));

// Set Window to location of first error

function setWindowLocationToError(element) {

  const elm = document.body;
  let from = document.documentElement.scrollTop || document.body.scrollTop;
  const to = element.getBoundingClientRect();
  const toPosition = to.top - from;
  const currentPosition = window.pageYOffset;
  let frames = 60;
  const jump = (toPosition - from) / frames;
  from = currentPosition;

  function scroll() {

    if (frames > 0) {

      const position = from + jump;

      from = position;
      elm.scrollTop = from;
      document.documentElement.scrollTop = from;

      frames--;
      window.requestAnimationFrame(scroll);

    }

  }

  window.requestAnimationFrame(scroll);

}

// Export

export default function() {

  form.addEventListener('submit', (e) => {

    e.preventDefault();

    let validForm = false;
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
        setWindowLocationToError(elm);
        return;

        if (i == fields.length - 1) validForm = true;

      } else {

        if (validForm) {
          form.submit();
        }

      }

    });



  });

}
