
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import submitToken from './submitToken.js';

// Variables

const form = document.querySelector('#paymentMethod');
const paymentRequestWrapper = document.querySelector('.payment-request-wrapper');
const paymentRequestElement = document.querySelector('#payment-request-button');
const errorElement = document.getElementById('card-errors');
const costString = form.getAttribute('data-cost');
const totalCostInCents = parseInt(costString * 100);

// Export

export default function(stripeRef, elementsRef) {

  const stripe = stripeRef;
  const elements = elementsRef;

  const paymentRequest = stripe.paymentRequest({
    country: 'US',
    currency: 'usd',
    total: {
      label: 'Macro Meals Purchase',
      amount: totalCostInCents,
    },
  });
  const paymentRequestbutton = elements.create('paymentRequestButton', {
    paymentRequest: paymentRequest,
    label: 'Macro Meals',
    style: {
      paymentRequestButton: {
        type: 'buy',
        theme: 'light',
        height: '44px',
      },
    },
  });

  paymentRequest.canMakePayment().then( (result) => {

    if (result != null) {

      if (result.applePay != false) {
        paymentRequestbutton.mount('#payment-request-button');
        paymentRequestWrapper.style.display = 'block';
      }

    }

  });

  paymentRequest.on('token', function(result) {

    submitToken.stripe(result.token.id).then( (response) => {

      if (response.error) {

        errorElement.innerHTML = `
          <p>${response.error}</p>
          <p>Your cart has been saved.  Please contact our support team at <a href="help@macromeals.life">help@macromeals.life</a> to process your payment.</p>
        `;

        errorElement.style.display = 'block';
      }

    });

  });

}
