
// import

import findParentNode from 'scripts/helpers/findParentNode.js';
import checkProductQuantity from 'scripts/helpers/cart/checkProductQuantity.js';
import postToCart from 'scripts/helpers/cart/postToCart.js';
import displayCartTotalInHeader from 'scripts/helpers/cart/displayCartTotalInHeader.js';

// Variables

const form = document.querySelector('form#product-addition');
const submissionConfirmation = document.querySelector('.product-post-submission');
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const submit = form.querySelector('input[type="submit"]');
const totalPrice = form.querySelector('[data-total="price"]');
let showSubmit = false;

// Caculate Total for User

function caculateTotal() {

  let total = 0;

  inputs.forEach((input) => {

    const parent = findParentNode(input,'input-container');;
    const hiddenQuanity = parent.querySelector('input[name="qty"]');
    const priceString = parent.querySelector('.price > span').innerHTML;
    const price = priceString.slice(1, priceString.length);
    const itemTotal = input.value * price;

    total = total + itemTotal;
    hiddenQuanity.value = input.value;

  });

  if (total > 0 ) {
    if(totalPrice) totalPrice.innerHTML = `$${total.toFixed(2)}`;
    submit.style.display = 'block';
  } else {
    if(totalPrice) totalPrice.innerHTML = ``;
    submit.style.display = 'none';
  }

}

function postSubmission() {

  form.style.display = 'none';
  submissionConfirmation.style.display = 'block';
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;

}

// Submit

function submitForm(e) {

  e.preventDefault();

  let inputWithValues = inputs.filter( (input) => {
    return input.value > 0;
  });

  inputWithValues.forEach( (input, i) => {

    const id = input.getAttribute('data-id');
    let data = `${window.csrfTokenName}=${window.csrfTokenValue}&`;

    // Iterate over input to post to cart

    data += `purchasableId=${id}&qty=${input.value}`;

    const response = postToCart(data).then( (response) => {

      if (response.success) {

        input.value = 0;

        if (i == inputWithValues.length - 1) {
          displayCartTotalInHeader();
          postSubmission();
        }

      }

    });

  });

}

// Export

export default function() {

  inputs.forEach( (input) => {

    const container = findParentNode(input,'input-container');
    const errors = container.querySelector('.errors');
    const stockText = errors.querySelector('.stock');

    input.addEventListener('focus', () => {

      if (input.value == 0) input.value = '';

    });

    input.addEventListener('keyup', (e) => {
      caculateTotal();
    });

    input.addEventListener('change', (e) => {
      checkProductQuantity(input, stockText).then(() => {
        caculateTotal();
      });
    });

    input.addEventListener('blur', (e) => {

      if (input.value == '') {
        input.value = 0;
      } else {
        caculateTotal();
      }

    });

  });

  form.addEventListener('submit', (e) => { submitForm(e) });

}
