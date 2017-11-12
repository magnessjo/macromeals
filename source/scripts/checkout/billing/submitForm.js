
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import fetchPostData from 'scripts/helpers/fetchPostData.js';

// Variables

let stripe;
let elements;
let card;

const form = document.querySelector('form#payment');
const errorElement = document.getElementById('card-errors');
const cardNameElement = form.querySelector('#card-name-element');
const submitButton = form.querySelector('input[type="submit"]');
const paymentRequestWrapper = form.querySelector('.request-button');

const costString = form.getAttribute('data-cost');
const totalCostInCents = parseInt(costString * 100);


// Load

function load() {

  const style = {
    base: {
      iconColor: '#000',
      color: '#000',
      fontFamily: 'acumin-pro, arial, sans-serif',
      fontWeight: 400,
    },
  };

  const cardNumberElement = elements.create('cardNumber', { style: style });
  const cardExpiryElement = elements.create('cardExpiry', { style: style });
  const cardCvcElement = elements.create('cardCvc', { style: style });
  const postalCodeElement = elements.create('postalCode', { style: style });
  const inputs = [ cardNumberElement, cardExpiryElement, cardCvcElement, postalCodeElement ];

  // Set card for token

  card = cardNumberElement;

  cardNumberElement.mount('#card-number-element');
  cardExpiryElement.mount('#card-expiry-element');
  cardCvcElement.mount('#card-cvc-element');
  postalCodeElement.mount('#postal-code-element');

  inputs.forEach( (input) => {

    const element = input._parent;
    const parent = findParentNode(element, 'field');

    input.addEventListener('blur', () => {

      if (input._complete) {
        parent.setAttribute('valid', true);
      }

      if (input._invalid) {
        parent.setAttribute('valid', false);
      }

    });

    input.addEventListener('focus', () => {

      parent.removeAttribute('valid');
      errorElement.style.display = 'none';

    });

  });

}

// submit

function submitForm() {

  form.addEventListener('submit', (e) => {

    e.preventDefault();
    submitButton.disabled = true;
    const nameInput = cardNameElement.querySelector('input');

    stripe.createToken(card, {
      name : nameInput.value,
      address_country: 'US',
    }).then((result) => {

      if (result.error) {
        errorElement.textContent = result.error.message;
        errorElement.style.display = 'block';
        submitButton.disabled = false;
      } else {
        addTokenAndSubmit(result.token.id);
      }

    });

  });

}

function addTokenAndSubmit(token) {

  fetchPostData(`${window.csrfTokenName}=${window.csrfTokenValue}&stripeToken=${token}`, '/actions/commerce/payments/pay').then( (response) => {

    if (response.success) {

      window.location.href = '/checkout/complete';

    } else {
      console.log(response);
      const text = document.createElement('p');
      text.innerHTML = 'There was an error submitting your payment.  Your cart has been saved.  Please contact our support team at <a href="help@macromeals.life">help@macromeals.life</a> to process your payment.'
      errorElement.appendChild(text);
      errorElement.style.display = 'block';
    }

  });

}

function paymentRequest() {

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
  });

  paymentRequest.canMakePayment().then((result) => {

    if (result) {
      paymentRequestbutton.mount('#payment-request-button');
      paymentRequestWrapper.style.display = 'block';
    }

  });

  paymentRequest.on('token', function(ev) {
    addTokenAndSubmit(ev.token.id);
  });

}

// Export

export default function() {

  if (window.location.origin == 'https://www.macromeals.life') {
    stripe = Stripe('pk_live_5eXACjQVrzeUQpCpF0ydV15h');
  } else {
    stripe = Stripe('pk_test_UrlLqyCEbnu4hXNhRRFaA16n');
  }

  elements = stripe.elements();

  load();
  submitForm();
  paymentRequest();

}
