
// import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';
import checkFormFieldsForValidAttribute from 'scripts/helpers/form/checkFormFieldsForValidAttribute.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const shippingForm = document.querySelector('#shipping-calculator');
const loaderAnimation = shippingForm.querySelector('.loader');
const result = shippingForm.querySelector('.result');

const inputs = shippingForm.querySelectorAll('input:not([type="submit"])')
const submit = shippingForm.querySelector('input[type="submit"]');


// Set Rate

function setRate() {

  const url = '/actions/MacroCommerce/ShippingRates';
  const address = shippingForm.querySelector('input[name="address"]').value;
  const city = shippingForm.querySelector('input[name="city"]').value;
  const zip = shippingForm.querySelector('input[name="zipCode"]').value;
  const select = shippingForm.querySelector('select[name="state"]');
  const state = select.options[select.selectedIndex].value;
  let data = `${window.csrfTokenName}=${window.csrfTokenValue}&address=${address}&city=${city}&zip=${zip}&state=${state}&quantity=1`;

  console.log(data);

  fetchPostData(data,url).then( (response) => {

    loaderAnimation.style.display = 'none';

    if (response.success) {
      const cost = parseInt(response.amount);
      const isGround = response.type == 'ground';

      if (isGround) {
        if (response.itemSubtotal > 50) {
          result.innerHTML = `<p>Your Estimate<span>$${cost.toFixed(2)}</span></p>`;
        } else {
          result.innerHTML = `
            <p>Your Estimate<span>$${cost.toFixed(2)}</span></p>
            <p class="">Orders over $50 ship for $10.00</p>
          `;
        }

      } else {
        result.innerHTML = `<p>Your Estimate<span>$${cost.toFixed(2)}</span></p>`;
      }

      inputs.forEach( (input) => input.value = '');
    } else {
      result.innerHTML = `There was an error getting your estimate.  Please contact us directly at <a href="info@macromeals.life">info@macromeals.life</a> for an estimate.`;
    }

  });

}

// Export

export default function() {

  shippingForm.addEventListener('submit', (e) => {

    e.preventDefault();

    loaderAnimation.style.display = 'block';
    inputQuery(shippingForm, false);

    const isValid = checkFormFieldsForValidAttribute(inputs);
    if (isValid) setRate();

    ga('send', {
      hitType: 'event',
      eventCategory: 'Shipping quote',
      eventAction: 'Show',
      eventLabel: 'Get Shipping Quote'
    });

  });

}
