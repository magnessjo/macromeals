
// Import

import formValidation from './formValidation.js';

// Variables

const container = document.querySelector('#billing-address');
const inputs = Array.from(container.querySelectorAll('inputs[type="text"]'));
const checkbox = container.querySelector('input[type="checkbox"]');
const hiddenInput = container.querySelector('input[name="sameAddress"]');
const fieldsWrapper = container.querySelector('.billing-fields');

// Export

export default function() {

  checkbox.addEventListener('change', () => {

    if (checkbox.checked) {
      hiddenInput.value = 1;
      fieldsWrapper.style.display = 'none';
    } else {
      hiddenInput.value = 0;
      fieldsWrapper.style.display = 'block';
      formValidation();
    }

  });

}
