
// Import

import findParentNode from 'scripts/helpers/findParentNode.js';
import postToCart from 'scripts/helpers/cart/postToCart.js';
import updateCartItem from 'scripts/helpers/cart/updateCartItem.js';
import displayCartTotalInHeader from 'scripts/helpers/cart/displayCartTotalInHeader.js';

// Update Cart

function updateCart(input) {

  const quantity = input.value;
  const parent = findParentNode(input, 'field');
  const itemId = input.getAttribute('data-id');
  const lineId = input.getAttribute('data-item-id');
  const buttons = Array.from(parent.querySelectorAll('button'));

  console.log(input);
  console.log(quantity);

  buttons.forEach( (button) => { button.disabled = true } );

  if (lineId == null) {

    // Set new line update

    const postData = `${window.csrfTokenName}=${window.csrfTokenValue}&purchasableId=${itemId}&qty=${quantity}`;

    postToCart(postData).then( (response) => {

      const lineItems = response.cart.lineItems;
      for (const key in lineItems) {
        if (lineItems[key].purchasableId == parseInt(itemId)) input.setAttribute('data-item-id', lineItems[key].id );
      }
      buttons.forEach( (button) => { button.disabled = false } );
      displayCartTotalInHeader();
    });

  } else {

    // Update Existing

    const postData = `${window.csrfTokenName}=${window.csrfTokenValue}&lineItemId=${lineId}&qty=${quantity}`;

    updateCartItem(postData).then( (response) => {
      displayCartTotalInHeader();
      buttons.forEach( (button) => { button.disabled = false } );
    });

  }



}

// Variables

export default function(element) {

  const parent = findParentNode(element, 'input-container');
  const inputs = Array.from(parent.querySelectorAll('input[type="number"]'));
  const additionText = parent.querySelector('.addition-text');
  const title = inputs[0].getAttribute('data-title');
  let showAdditionMessage = false;
  let message = '';
  let totalQuantity = 0;
  let andText = false;

  updateCart(element);

  inputs.forEach( (input, i) => {

    if (input.value > 0) {

      const size = input.getAttribute('data-size');
      const quantity = input.value;
      totalQuantity += quantity;

      if (andText) message += ' and ';

      showAdditionMessage = true;
      message += `${quantity} ${size}`;
      andText = true;

    }

  });

  if (showAdditionMessage) {
    additionText.style.display = 'block';
    const mealText = totalQuantity > 1 ? 'meals have' : 'meal has'
    additionText.innerHTML = `<span>${message}</span> ${title} ${mealText} been added to your cart`;
  } else {
    additionText.style.display = 'none';
  }

  // ga('ec:addProduct', {
  //   'name': title,
  //   'variant': size,
  //   'quantity': quantity
  // });

}
