
// import

import fetchData from 'scripts/helpers/fetchPostData.js';
import validation from 'scripts/helpers/inputValidation.js';
import findParentNode from 'scripts/helpers/findParentNode.js';
import checkProductQuantity from 'scripts/helpers/checkProductQuantity.js';
import 'whatwg-fetch';

// Variables

const section = document.querySelector('#details');
const form = section.querySelector('form');
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const submit = form.querySelector('input[type="submit"]');
const totalPrice = form.querySelector('[data-total="price"]');
let showSubmit = false;

// Total

function caculateTotal(total) {
  totalPrice.innerHTML = `$${total}`;
}

// Reset Total

function resetTotal() {

}

// check values

function checkInputValues() {

  let isError = false;
  let total = 0;

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

    if (!isError) {

      const wrapper = input.parentNode;
      const parent = wrapper.parentNode;
      const hiddenQuanity = parent.querySelector('input[name="qty"]');
      const priceString = parent.querySelector('.price').innerHTML;
      const price = priceString.slice(1, priceString.length);
      const itemTotal = input.value * price;

      total = total + itemTotal;
      hiddenQuanity.value = input.value;

      showSubmit = true;
      caculateTotal(total);

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

// Submit

function submitForm(e) {

  let submittedCorrectly = true;

  e.preventDefault();

  inputs.forEach((input, i) => {

    let data = '';

    data += `${window.csrfTokenName}=${window.csrfTokenValue}&`;

    if (input.value != 0) {

      const id = input.getAttribute('data-id');

      data += `purchasableId=${id}&`;
      data += `qty=${input.value}`;
      fetchData(data, '/actions/commerce/cart/updateCart').then((response) => {

        if (response.success) {
          input.value = 0;
        } else {
          submittedCorrectly = false;
        }

      });

    }

    if (i == inputs.length - 1) {

      if (submittedCorrectly) {
        form.style.display = 'none';
      }

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
