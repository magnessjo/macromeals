
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const form = document.querySelector('form#pickup-options');
const shippingList = form.querySelector('#pickup-list');
const buttons = Array.from(shippingList.querySelectorAll('button'));
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
      const cost = parent.getAttribute('data-cost');

      hiddenInput.value = handle;
      setSummaryCost(name, cost);

      buttons.forEach((btn) => {
        if (btn == button) {
          btn.disabled = true;
        } else {
          btn.disabled = false;
        }
      });

    });

  });

}
