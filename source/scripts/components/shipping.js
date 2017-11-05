
// import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';
import checkFormFieldsForValidAttribute from 'scripts/helpers/form/checkFormFieldsForValidAttribute.js';

// Variables

const shippingForm = document.querySelector('#shipping-calculator');
const inputs = shippingForm.querySelectorAll('input:not([type="submit"])')
const submit = shippingForm.querySelector('input[type="submit"]');

const modal = document.querySelector('.shipping-cost-modal');
const loaderAnimation = modal.querySelector('.loader');
const textContainer = modal.querySelector('.text-container');
const resultText = textContainer.querySelector('.acumin-large-bold');
const modalButton = modal.querySelector('button');

// Set Rate

function setRate() {

  const url = '/actions/MacroCommerce/ShippingRates';
  const zip = shippingForm.querySelector('input[name="zipCode"]').value;
  const quantity = shippingForm.querySelector('input[name="quantity"]').value;
  let data = `${window.csrfTokenName}=${window.csrfTokenValue}&zip=${zip}&quantity=${quantity}`;

  modal.style.display = 'block';

  fetchPostData(data,url).then( (response) => {

    const text = document.createElement('p');
    loaderAnimation.style.display = 'none';

    if (response.success) {
      text.innerHTML = `<span>Your Estimate</span>$${response.amount}`;
      text.classList.add('result');
      inputs.forEach( (input) => input.value = '');
    } else {
      text.innerHTML = `There was an error getting your estimate.  Please contact us directly at <a href="info@macromeals.life">info@macromeals.life</a> for an estimate.`;
    }

    textContainer.appendChild(text);

  });

}

// Export

export default function() {

  shippingForm.addEventListener('submit', (e) => {

    e.preventDefault();

    inputQuery(shippingForm, false);

    const isValid = checkFormFieldsForValidAttribute(inputs);
    if (isValid) setRate();

  });

  modalButton.addEventListener('click', () => {

    const text = textContainer.querySelector('p');

    modal.style.display = 'none';
    loaderAnimation.style.display = 'block';
    text.remove();

  });

}
