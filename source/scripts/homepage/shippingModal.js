
// import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';
import checkFormFieldsForValidAttribute from 'scripts/helpers/form/checkFormFieldsForValidAttribute.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const modal = document.querySelector('.shipping-modal');
const showButton = document.querySelector('.show-shipping-modal');
const closeButton = modal.querySelector('button');
const loaderAnimation = modal.querySelector('.loader');
const result = modal.querySelector('.result');

const shippingForm = document.querySelector('#shipping-calculator');
const inputs = shippingForm.querySelectorAll('input:not([type="submit"])')
const submit = shippingForm.querySelector('input[type="submit"]');


// Set Rate

function setRate() {

  const url = '/actions/MacroCommerce/ShippingRates';
  const zip = shippingForm.querySelector('input[name="zipCode"]').value;
  const quantity = shippingForm.querySelector('input[name="quantity"]').value;
  let data = `${window.csrfTokenName}=${window.csrfTokenValue}&zip=${zip}&quantity=${quantity}`;

  fetchPostData(data,url).then( (response) => {

    loaderAnimation.style.display = 'none';

    if (response.success) {
      result.innerHTML = `<p><span>Your Estimate</span>$${response.amount.toFixed(2)}</p>`;
      inputs.forEach( (input) => input.value = '');
    } else {
      result.innerHTML = `There was an error getting your estimate.  Please contact us directly at <a href="info@macromeals.life">info@macromeals.life</a> for an estimate.`;
    }

  });

}

// Export

export default function() {

  showButton.addEventListener('click', () => {
    modal.setAttribute('aria-hidden', false);
    result.innerHTML = '';
  });

  closeButton.addEventListener('click', (e) => {
    e.preventDefault();
    modal.setAttribute('aria-hidden', true);
  });

  shippingForm.addEventListener('submit', (e) => {

    e.preventDefault();

    loaderAnimation.style.display = 'block';
    inputQuery(shippingForm, false);

    const isValid = checkFormFieldsForValidAttribute(inputs);
    if (isValid) setRate();

  });

}
