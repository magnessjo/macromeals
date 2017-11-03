
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import removeCartItem from 'scripts/helpers/cart/removeCartItem.js';
import displayCartTotalInHeader from 'scripts/helpers/cart/displayCartTotalInHeader.js';
import updateCartTotals from './updateCartTotals.js';

// Variables

const body = document.querySelector('body');
const form = document.querySelector('form#product-list');
const buttons = Array.from(form.querySelectorAll('.remove'));

// Show modal

function showModal(button) {

  const parent = findParentNode(button, 'order-item');
  const title = parent.querySelector('h2');
  const size = parent.querySelector('h2 span');

  const modal = document.createElement('div');
  const text = document.createElement('p');

  const buttonWrapper = document.createElement('div');
  const cancelButton = document.createElement('button');
  const confirmButton = document.createElement('button');

  function removeModal() {
    modal.remove();
  }

  modal.classList.add('modal');

  buttonWrapper.classList.add('button-wrapper');
  cancelButton.classList.add('cancel');
  confirmButton.classList.add('confirm');

  text.innerHTML = `
    Please confirm that you would like to remove ${title.innerHTML} from your cart
  `;

  cancelButton.innerHTML = 'Cancel';
  cancelButton.addEventListener('click', removeModal);

  confirmButton.innerHTML = 'Confrim';
  confirmButton.addEventListener('click', () => {

    const id = parent.getAttribute('data-id');
    let data = `${window.csrfTokenName}=${window.csrfTokenValue}&lineItemId=${id}`;

    removeCartItem(data).then( (data) => {

      parent.remove();
      removeCartItem();
      removeModal();
      displayCartTotalInHeader();
      updateCartTotals(data.cart);

    });

  });

  buttonWrapper.appendChild(cancelButton);
  buttonWrapper.appendChild(confirmButton);
  modal.appendChild(buttonWrapper);
  modal.appendChild(text);
  body.appendChild(modal);

}

// Export

export default function() {

  buttons.forEach((button) => {
    button.addEventListener('click', (e) => {
      e.preventDefault();
      showModal(button);
    });
  })

}
