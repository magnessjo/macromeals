
// import

import validation from 'scripts/helpers/form/inputValidationOld.js';
import findParentNode from 'scripts/helpers/findParentNode.js';
import checkProductQuantity from 'scripts/helpers/cart/checkProductQuantity.js';
import postToCart from 'scripts/helpers/cart/postToCart.js';

// Variables

const section = document.querySelector('#details');
const form = section.querySelector('form');
const submissionConfirmation = section.querySelector('.post-submission');
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const submit = form.querySelector('input[type="submit"]');
const totalPrice = form.querySelector('[data-total="price"]');
let showSubmit = false;

// Total

function caculateTotal() {

  let total = 0;

  inputs.forEach((input) => {

    const parent = findParentNode(input,'row-columns');;
    const hiddenQuanity = parent.querySelector('input[name="qty"]');
    const priceString = parent.querySelector('.price').innerHTML;
    const price = priceString.slice(1, priceString.length);
    const itemTotal = input.value * price;

    total = total + itemTotal;
    hiddenQuanity.value = input.value;

  });

  totalPrice.innerHTML = `$${total}`;

}

// Check Values & Set Validation or Totals

function checkInputValues() {

  let isError = false;

  inputs.forEach((input) => {

    if (isError) showSubmit = false;

    // Check for no entry

    isError = validation.checkForLength(input.value);
    if (isError) return;

    // Check for any digit other than a number

    isError = validation.checkForNumber(input.value);
    if (isError) return;

    // Check for a zero value

    isError = validation.checkForZeroValue(input.value);
    if (isError) caculateTotal();

    if (!isError) {
      showSubmit = true;
      caculateTotal();
    }

  });

}

// Update the interface based on conditions

function updateUI(e) {

  checkInputValues();

  if (showSubmit) {
    submit.style.display = 'block';
  } else {
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

    const container = findParentNode(input,'row-columns');
    const errors = container.querySelector('.errors');
    const stockText = errors.querySelector('.stock');

    input.addEventListener('keyup', (e) => updateUI(e, input) );

    input.addEventListener('change', (e) => {

      checkProductQuantity(input, stockText).then(() => {
        updateUI(e, input);
      });

    });

    input.addEventListener('blur', (e) => {

      if (input.value == '') {
        input.value = 0;
      } else {
        updateUI(e, input)
      }

    });

  });

  form.addEventListener('submit', (e) => { submitForm(e) });

}
