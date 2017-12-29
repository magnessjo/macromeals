
// Import

import updateDom from './updateDom.js';

// Variables

const form = document.querySelector('#product-addition');
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const submit = form.querySelector('input[type="submit"]');

// Export

export default function() {

  inputs.forEach( (input) => {

    input.addEventListener('focus', () => {

      if (input.value == '0') {
        input.value = '';
      }

    });

    input.addEventListener('blur', () => {

      if (input.value == '') {
        input.value = '0';
      }

      updateDom.button();
      updateDom.total();

    });

  });

}
