
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import fetchPostData from 'scripts/helpers/fetchPostData.js';

// Variables

const form = document.querySelector('form#pickup-options');
const shippingList = form.querySelector('#pickup-list');
const buttons = Array.from(shippingList.querySelectorAll('button:not(.show-pickups)'));
const hiddenInput = form.querySelector('input[name="shippingMethod"]');
const shippingSummary = document.querySelector('#shipping-summary');
const shippingSummaryMethod = shippingSummary.querySelector('.summary-method span');
const shippingSummaryCost = shippingSummary.querySelector('.summary-cost span');

function setSummaryCost(name, cost) {

  shippingSummaryMethod.innerHTML = name;
  shippingSummaryCost.innerHTML = `$${cost}`;

}

export default function() {

  buttons.forEach( (button) => {

    button.addEventListener('click', (e) => {

      e.preventDefault();

      const parent = findParentNode(button, 'shipping-type');
      const handle = parent.getAttribute('data-handle');
      const name = parent.getAttribute('data-name');
      let cost = parent.getAttribute('data-cost');

      hiddenInput.value = handle;

      if (handle == 'overnight') {

        const url = '/actions/MacroCommerce/ShippingRates';
        const zip = button.getAttribute('data-zip');
        const data = `${window.csrfTokenName}=${window.csrfTokenValue}&zip=${zip}&quantity=1`;

        fetchPostData(data,url).then( (response) => {
          setSummaryCost(name, response.amount);
        });

      } else {
        setSummaryCost(name, cost);
      }

      buttons.forEach((btn) => {
        if (btn == button) {
          btn.disabled = true;
          btn.innerHTML = 'Selected';
        } else {
          btn.disabled = false;
          btn.innerHTML = 'Select';
        }
      });

    });

  });

}
