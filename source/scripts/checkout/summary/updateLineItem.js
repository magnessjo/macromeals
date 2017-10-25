
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
const itemsAmount = cartTotal.querySelector('.items-amount');

function update(button, increase) {

  const parent = findParentNode(button, 'order-item');
  const actions = parent.querySelector('.item-actions');
  const currentElement = actions.querySelector('span');
  const currentQuantity = parseInt(currentElement.innerHTML);
  const id = parent.getAttribute('data-id');
  const qty = increase ? currentQuantity + 1 : currentQuantity - 1;
  let data = `${window.csrfTokenName}=${window.csrfTokenValue}&lineItemId=${id}&qty=${qty}`;

  updateCartItem(data).then(() => {

    currentElement.innerHTML = qty;
    displayCartTotalInHeader();
    getCartTotal().then( (number) => {
      console.log(number);
      itemsAmount.innerHTML = `$${parseFloat(number).toFixed(2)}`;
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
