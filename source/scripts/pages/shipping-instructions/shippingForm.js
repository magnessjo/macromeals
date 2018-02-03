
// import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';
import checkFormFieldsForValidAttribute from 'scripts/helpers/form/checkFormFieldsForValidAttribute.js';
import checkSelectFields from 'scripts/helpers/form/checkSelectFields.js';
import findParentNode from 'scripts/helpers/findParentNode.js';
import validation from 'scripts/helpers/form/validation.js';

// Variables

const shippingForm = document.querySelector('#shipping-calculator');
const loaderAnimation = shippingForm.querySelector('.loader');
const result = shippingForm.querySelector('.result');

const inputs = Array.from(shippingForm.querySelectorAll('input:not([type="submit"])'));
const selects = Array.from(shippingForm.querySelectorAll('select'));
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

  fetchPostData(data,url).then( (response) => {

    loaderAnimation.style.display = 'none';

    if (response.success) {

      const cost = parseInt(response.amount);
      const isGround = response.service == 'GND';

      // Post Submission State

      result.innerHTML = `<p>Your Estimate<span>$${cost.toFixed(2)}</span></p>`;

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

    } else {

      if (result.error) {
        result.innerHTML = `There was an error getting your estimate.  ${result.error}.  Please contact us directly at <a href="info@macromeals.life">info@macromeals.life</a> for an estimate.`;
      } else {
        result.innerHTML = `There was an error getting your estimate.  Please contact us directly at <a href="info@macromeals.life">info@macromeals.life</a> for an estimate.`;
      }

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

    const isInputsValid = checkFormFieldsForValidAttribute(inputs);
    const isSelectsValid = checkFormFieldsForValidAttribute(selects);
    inputQuery(shippingForm, false);
    checkSelectFields(selects, true);

    if (isInputsValid && isSelectsValid) {
      loaderAnimation.style.display = 'block';
      setRate();
    }

    ga('send', {
      hitType: 'event',
      eventCategory: 'Shipping quote',
      eventAction: 'Show',
      eventLabel: 'Get Shipping Quote'
    });

  });

}
