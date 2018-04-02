
// import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';
import checkFormFieldsForValidAttribute from 'scripts/helpers/form/checkFormFieldsForValidAttribute.js';
import checkSelectFields from 'scripts/helpers/form/checkSelectFields.js';
import findParentNode from 'scripts/helpers/findParentNode.js';
import validation from 'scripts/helpers/form/validation.js';
import shippingAlternatives from 'scripts/components/shipping-validation-alternatives.js';

// Variables

const shippingForm = document.querySelector('#shipping-calculator');
const loaderAnimation = shippingForm.querySelector('.loader');
const result = shippingForm.querySelector('.result');

const inputs = Array.from(shippingForm.querySelectorAll('input:not([type="submit"])'));
const selects = Array.from(shippingForm.querySelectorAll('select'));
const submit = shippingForm.querySelector('input[type="submit"]');

// Clear Form Values

function clearFormValues() {

  inputs.forEach( (input) => {
    const parent = findParentNode(input, 'field');
    input.value = '';
    parent.setAttribute('valid', false);
    parent.removeAttribute('has-error', false);
  });

  selects.forEach( (select) => {
    const parent = findParentNode(select, 'field');
    select.selectedIndex = 0;
    parent.setAttribute('valid', false);
    parent.removeAttribute('has-error');
  });

}

// Set Error

function setError() {
  result.innerHTML = `The address that you entered could not be validated.  Please contact us directly at <a href="info@macromeals.life">info@macromeals.life</a> for an estimate.`;
}

// Set Rate

function setRate(data) {

  const cost = parseInt(data.amount);

  // Post Submission State

  result.innerHTML = `<p>Your Estimate<span>$${cost.toFixed(2)}</span></p>`;
  // clearFormValues();

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

    console.log(response);

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

  // Shipping Form

  shippingForm.addEventListener('submit', (e) => {

    e.preventDefault();

    // const isInputsValid = checkFormFieldsForValidAttribute(inputs);
    // const isSelectsValid = checkFormFieldsForValidAttribute(selects);
    // inputQuery(shippingForm, false);
    // checkSelectFields(selects, true);
    //
    // if (isInputsValid && isSelectsValid) {
    //   loaderAnimation.style.display = 'block';
    //   setRate();
    // }

    fetchRate();

    ga('send', {
      hitType: 'event',
      eventCategory: 'Shipping quote',
      eventAction: 'Show',
      eventLabel: 'Get Shipping Quote'
    });

  });

}
