
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import updateCartItem from 'scripts/helpers/cart/updateCartItem.js';
import displayCartTotalInHeader from 'scripts/helpers/cart/displayCartTotalInHeader.js';
import getCartTotal from 'scripts/helpers/cart/getCartTotal.js';

// Variables

const form = document.querySelector('form');
const items = Array.from(form.querySelectorAll('.item-actions'));
const buttons = Array.from(form.querySelectorAll('.increment button'));
const cartTotal = form.querySelector('.cart-total');

// Disable Buttons

function enableButttons(buttons) {
  buttons.forEach( (button) => { button.disabled = false });
}

// Disable Buttons

function disableButttons(buttons) {
  buttons.forEach( (button) => { button.disabled = true });
}

// Update Total Cost

function updateTotalCost(displayNumber) {

  const itemsAmount = cartTotal.querySelector('[data-type="items-amount"]');
  itemsAmount.innerHTML = displayNumber;

}

// Update DOM

function update(button, increase) {

  // Dom Elements

  const parent = findParentNode(button, 'order-item');
  const actions = parent.querySelector('.item-actions');
  const incrementOptions = parent.querySelector('.increment');

  const currentQtyElement = incrementOptions.querySelector('span');
  const costElement = actions.querySelector('.cost');
  const buttons = Array.from(incrementOptions.querySelectorAll('button'));

  // Get Attributes

  const id = parent.getAttribute('data-id');

  // Set Quantity

  const currentQuantity = parseInt(currentQtyElement.innerHTML);
  const qty = increase ? currentQuantity + 1 : currentQuantity - 1;
  let data = `${window.csrfTokenName}=${window.csrfTokenValue}&lineItemId=${id}&qty=${qty}`;

  // Pre Process

  disableButttons(buttons);

  // Process Request

  updateCartItem(data).then(() => {

    currentQtyElement.innerHTML = qty;
    displayCartTotalInHeader();
    getCartTotal.allItemsWithAdjustments().then( (number) => {
      const displayNumber = `$${parseFloat(number).toFixed(2)}`;
      costElement.innerHTML = displayNumber;
      updateTotalCost(displayNumber);
      enableButttons(buttons);
    });

  });

}


// Export

export default function() {

  buttons.forEach((button) => {

    button.addEventListener('click', (e) => {

      e.preventDefault();
      let isIncrease = button.classList.contains('plus');
      update(button, isIncrease);

    });

  });

}
