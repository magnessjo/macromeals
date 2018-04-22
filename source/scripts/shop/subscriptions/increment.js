
// Imports

import updateTotal from './updateTotal.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const form = document.querySelector('form#weekly-subscriptions');
const buttons = Array.from(form.querySelectorAll('.increment button'));
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));

// Update DOM

function update(button, increase) {

  const parent = findParentNode(button, 'increment');
  const buttons = Array.from(parent.querySelectorAll('button'));
  const input = parent.querySelector('input');

  if (input.value > 0) {
    input.value = increase ? parseInt(input.value) + 1 : parseInt(input.value) - 1;
  } else {
    input.value = increase ? 1 : 0;
  }

  updateTotal(input);

}

// Export

export default function() {

  buttons.forEach( (button) => {

    button.addEventListener('click', (e) => {

      e.preventDefault();
      let isIncrease = button.classList.contains('plus');
      update(button, isIncrease);

    });

  });

}
