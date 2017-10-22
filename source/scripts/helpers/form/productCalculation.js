
// import

import findParentNode from 'scripts/helpers/findParentNode.js';
import checkProductQuantity from 'scripts/helpers/cart/checkProductQuantity.js';
import postToCart from 'scripts/helpers/cart/postToCart.js';

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
    const priceString = parent.querySelector('.price').innerHTML;
    const price = priceString.slice(1, priceString.length);
    const itemTotal = input.value * price;

    total = total + itemTotal;
    hiddenQuanity.value = input.value;

  });

  if (total > 0 ) {
    totalPrice.innerHTML = `$${total}`;
    submit.style.display = 'block';
  } else {
    totalPrice.innerHTML = ``;
    submit.style.display = 'none';
  }

}

function postSubmission() {

  form.style.display = 'none';
  submissionConfirmation.style.display = 'block';

}

// Submit

function submitForm(e) {

  const totalInputs = inputs.length - 1;
  let submittedCorrectly = true;

  e.preventDefault();

  inputs.forEach((input, i) => {

    const id = input.getAttribute('data-id');
    let data = `${window.csrfTokenName}=${window.csrfTokenValue}&`;

    // Iterate over input to post to cart

    if (input.value != 0) {

      data += `purchasableId=${id}&qty=${input.value}`;
      const response = postToCart(data).then(() => {
        response.success ? input.value = 0 : submittedCorrectly = false
      });

    }

    // Remove the button upon Submission

    if (i == totalInputs && submittedCorrectly) {
      postSubmission();
    }

  });

}

// Export

export default function() {

  inputs.forEach((input) => {

    const container = findParentNode(input,'input-container');
    const errors = container.querySelector('.errors');
    const stockText = errors.querySelector('.stock');

    input.addEventListener('keyup', (e) => {
      caculateTotal();
    });

    input.addEventListener('change', (e) => {
      checkProductQuantity(input, stockText);
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
