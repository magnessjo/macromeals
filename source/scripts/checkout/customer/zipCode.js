
// Import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const form = document.querySelector('#address-info');
const input = form.querySelector('input[name="shippingAddress[zipCode]"]');
const parent = findParentNode(input, 'field');
const textContainer = parent.querySelector('.shipping-cost');
const text = textContainer.querySelector('p');
const submitButton = form.querySelector('input[type="submit"]');

// Set Rate

function setRate(showSubmitButton = false) {

  const url = '/actions/MacroCommerce/ShippingRates';
  const quantity = form.querySelector('input[name="quantity"]').value;
  const shippingMethod = form.getAttribute('shipping-method');
  let data = `${window.csrfTokenName}=${window.csrfTokenValue}&zip=${input.value}&quantity=${quantity}`;

  fetchPostData(data,url).then( (response) => {

    if (response.success) {
      text.innerHTML = `The shipping costs for ${input.value} are $${response.amount}`;
      if (shippingMethod == 'overnight' && showSubmitButton) submitButton.disabled = false;
    } else {
      if (shippingMethod == 'overnight' && showSubmitButton) submitButton.disabled = true;
      text.innerHTML = `
        ${response.error.Message}</br>
        Please contact us at <a href="info@macromeals.life">info@macromeals.life</a> for help resolving the issue.
      `;
    }

    textContainer.style.display = 'block';

  });

}

// Export

export default function() {

  if (input.value) setRate(true);

  input.addEventListener('blur', () => {

    const isParentValid = parent.getAttribute('valid');

    if (isParentValid == 'true') setRate();

  });

}
