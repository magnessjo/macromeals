
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import updateCartItem from 'scripts/helpers/cart/updateCartItem.js';
import displayCartTotalInHeader from 'scripts/helpers/cart/displayCartTotalInHeader.js';
import getCartTotal from 'scripts/helpers/cart/getCartTotal.js';
import formatStringForDollar from 'scripts/helpers/formatStringForDollar.js';
import updateCartTotals from './updateCartTotals.js';

// Variables

const form = document.querySelector('form');
const items = Array.from(form.querySelectorAll('.item-actions'));
const buttons = Array.from(form.querySelectorAll('.increment button'));

// Disable Buttons

function enableButttons(buttons) {
  buttons.forEach( (button) => { button.disabled = false });
}

// Disable Buttons

function disableButttons(buttons) {
  buttons.forEach( (button) => { button.disabled = true });
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

  const itemId = parent.getAttribute('data-id');

  // Set Quantity

  const currentQuantity = parseInt(currentQtyElement.innerHTML);
  const qty = increase ? currentQuantity + 1 : currentQuantity - 1;
  let postData = `${window.csrfTokenName}=${window.csrfTokenValue}&lineItemId=${itemId}&qty=${qty}`;

  // Pre Process

  disableButttons(buttons);

  // Process Request

  updateCartItem(postData).then( (data) => {

    const cart = data.cart;
    const lineItems = cart.lineItems;

    for (const key in lineItems) {

      const item = lineItems[key];

      if (item.id == itemId) {
        const displayNumber = formatStringForDollar(item.total);
        costElement.innerHTML = displayNumber;
      }

    }

    currentQtyElement.innerHTML = qty;

    displayCartTotalInHeader();
    updateCartTotals(cart);
    enableButttons(buttons);

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
