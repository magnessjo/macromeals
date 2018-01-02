
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import fetchPostData from 'scripts/helpers/fetchPostData.js';

// Variables

const stripe = window.location.origin == 'https://www.macromeals.life' ? Stripe('pk_live_5eXACjQVrzeUQpCpF0ydV15h') : Stripe('pk_test_UrlLqyCEbnu4hXNhRRFaA16n');
const elements = stripe.elements();
const paymentRequestWrapper = document.querySelector('.payment-request-wrapper');
const paymentRequestElement = document.querySelector('#payment-request-button');
const costString = paymentRequestWrapper.getAttribute('data-cost');
const totalCostInCents = parseInt(costString * 100);

// Post Request

function addTokenAndSubmit(token) {

  fetchPostData(`${window.csrfTokenName}=${window.csrfTokenValue}&stripeToken=${token}`, '/actions/commerce/payments/pay').then( (response) => {

    if (response.success) {

      window.location.href = '/checkout/complete';

    } else {
      console.log(response);

      submitButton.disabled = false;
      loader.style.display = 'none';

      errorElement.innerHTML = `
        <p>${response.error}</p>
        <p>Your cart has been saved.  Please contact our support team at <a href="help@macromeals.life">help@macromeals.life</a> to process your payment.</p>
      `;

      errorElement.style.display = 'block';
    }

  });

}

// Export

export default function() {

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
    label: 'text',
    style: {
      paymentRequestButton: {
        type: 'default',
        theme: 'dark',
        height: '44px',
      },
    },
  });

  paymentRequest.canMakePayment().then( (result) => {

    if (result.applePay != false) {
      paymentRequestbutton.mount('#payment-request-button');
      paymentRequestWrapper.style.display = 'block';
    }

  });

  paymentRequest.on('token', function(ev) {
    addTokenAndSubmit(ev.token.id);
  });

}
