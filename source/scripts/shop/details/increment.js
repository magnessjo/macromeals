
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import updateCartItem from 'scripts/helpers/cart/updateCartItem.js';
import displayCartTotalInHeader from 'scripts/helpers/cart/displayCartTotalInHeader.js';
import formatStringForDollar from 'scripts/helpers/formatStringForDollar.js';
import updateCartTotals from 'scripts/helpers/cart/updateCartTotals.js';

// Variables

const form = document.querySelector('form#product-addition');
const buttons = Array.from(form.querySelectorAll('.increment button'));
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const totalElement = form.querySelector('[data-total="price"]');

// Disable Buttons

function enableButttons(buttons) {
  buttons.forEach( (button) => { button.disabled = false });
}

// Disable Buttons

function disableButttons(buttons) {
  buttons.forEach( (button) => { button.disabled = true });
}

function updateTotal() {

  let total = 0;

  inputs.forEach( (input) => {

    const id = input.getAttribute('data-id');
    const cost = input.getAttribute('data-cost');
    total += parseInt(input.value) * parseFloat(cost);

  });

  totalElement.innerHTML = `$${total}`;

}


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

  disableButttons(buttons);
  updateTotal();

  setTimeout( () => {
    enableButttons(buttons);
  }, 100)

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
