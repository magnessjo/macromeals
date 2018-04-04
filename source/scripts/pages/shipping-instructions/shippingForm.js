
// import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';
import checkFormFieldsForValidAttribute from 'scripts/helpers/form/checkFormFieldsForValidAttribute.js';
import checkSelectFields from 'scripts/helpers/form/checkSelectFields.js';
import findParentNode from 'scripts/helpers/findParentNode.js';
import validation from 'scripts/helpers/form/validation.js';
import shippingAlternatives from 'scripts/components/shipping-validation-alternatives.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';

// Variables

const shippingForm = document.querySelector('#shipping-calculator');
const loaderAnimation = shippingForm.querySelector('.loader');
const result = shippingForm.querySelector('.result');

const inputs = Array.from(shippingForm.querySelectorAll('input:not([type="submit"])'));
const selects = Array.from(shippingForm.querySelectorAll('select'));
const submit = shippingForm.querySelector('input[type="submit"]');

// Set Error

function setError() {
  result.innerHTML = `The address that you entered could not be validated.  Please contact us directly at <a href="info@macromeals.life">info@macromeals.life</a> for an estimate.`;
}

// Set Rate

function setRate(data) {

  const cost = parseInt(data.amount);
  result.innerHTML = `<p>Your Estimate<span>$${cost.toFixed(2)}</span></p>`;

}

// Fetch Rate

function fetchRate() {

  const url = '/shippingRates';
  const address = shippingForm.querySelector('input[name="address"]').value;
  const city = shippingForm.querySelector('input[name="city"]').value;
  const zip = shippingForm.querySelector('input[name="zipCode"]').value;
  const select = shippingForm.querySelector('select[name="state"]');
  const state = select.options[select.selectedIndex].value;
  const data = `${window.csrfTokenName}=${window.csrfTokenValue}&address=${address}&city=${city}&zip=${zip}&state=${state}&quantity=1`;

  fetchPostData(data, url).then( (response) => {

    loaderAnimation.style.display = 'none';

    scrollToLocation(result, 120);

    if (!response.success) {

      if (response.alternatives && response.alternatives.length > 0) {
        shippingAlternatives(response.alternatives, fetchRate, setError);
      } else {
        setError();
      }

    }

    if (response.success) {
      setRate(response);
    }

  });

}

// Export

export default function() {

  // Event Listeners For Inputs

  checkSelectFields(selects);
  inputQuery(shippingForm);

  // Check for Valid Form to show Submit Button

  inputs.forEach( (input) => {

    input.addEventListener('blur', () => {
      const isInputsValid = checkFormFieldsForValidAttribute(inputs);
      const isSelectsValid = checkFormFieldsForValidAttribute(selects);
      if (isInputsValid && isSelectsValid) submit.disabled = false;
    });

  });

  selects.forEach( (select) => {

    select.addEventListener('change', () => {
      const isInputsValid = checkFormFieldsForValidAttribute(inputs);
      const isSelectsValid = checkFormFieldsForValidAttribute(selects);
      if (isInputsValid && isSelectsValid) submit.disabled = false;
    });

  });

  // Shipping Form Submit

  shippingForm.addEventListener('submit', (e) => {

    e.preventDefault();
    loaderAnimation.style.display = 'block';
    fetchRate();

    ga('send', {
      hitType: 'event',
      eventCategory: 'Shipping quote',
      eventAction: 'Show',
      eventLabel: 'Get Shipping Quote'
    });

  });

}
