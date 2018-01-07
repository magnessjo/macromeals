
// Import

import postToCart from 'scripts/helpers/cart/postToCart.js';
import displayCartTotalInHeader from 'scripts/helpers/cart/displayCartTotalInHeader.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';

// Variables

const formSection = document.querySelector('#product-actions');
const form = formSection.querySelector('#product-addition');
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const submit = form.querySelector('input[type="submit"]');
const totalText = form.querySelector('[data-total="price"]');

let items = [];

// Post submission

function postSubmission() {

  const postSection = document.querySelector('#post-submission');
  const orderText = postSection.querySelector('.order');
  let totalQuantity = 0;
  let text = '';

  items.forEach( (item, i) => {
    if (i > 0) text += ' and ';
    text += `${item.qty} ${item.size}`;
  });

  orderText.innerHTML = `Your order of<span>${text}</span> ${items[0].name} has been added to your cart.`
  postSection.style.display = 'block';
  scrollToLocation(postSection, 120);

}

// Export

export default function() {

  form.addEventListener('submit', e => {

    e.preventDefault();
    items = [];

    let inputWithValues = inputs.filter( (input) => {
      return input.value > 0;
    });

    inputWithValues.forEach( (input, i) => {

      const id = input.getAttribute('data-id');
      const size = input.getAttribute('data-size');
      const name = input.getAttribute('data-name');
      let data = `${window.csrfTokenName}=${window.csrfTokenValue}&`;
      let obj = {};

      obj.size = size;
      obj.qty = input.value;
      obj.name = name;
      items.push(obj);

      data += `purchasableId=${id}&qty=${input.value}`;

      postToCart(data).then( (response) => {

        if (response.success) {

          input.value = 0;
          submit.disabled = true;

          if (i == inputWithValues.length - 1) {
            displayCartTotalInHeader();
            postSubmission();
            totalText.innerHTML = '$0.00';
          }

        }

      });

    });

  });

}
