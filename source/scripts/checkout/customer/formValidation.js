
// Import

import inputValidation from 'scripts/helpers/inputValidation.js';

// Variables

const form = document.querySelector('form');
const inputs = Array.from(form.querySelectorAll('input[type="text"]'));


// Export

export default function(showError) {

  inputs.forEach((input) => {

    const parent = input.parentNode;
    const attString = input.getAttribute('validation');
    const validation = attString ? attString.split(',') : [];

    inputValidation.required(input, parent, showError);

    if (validation.length > 0) {

      validation.forEach((fun, i) => {

        const name = fun;
        inputValidation[`${name}`](input, parent, showError);

      });

    }

  });

}
