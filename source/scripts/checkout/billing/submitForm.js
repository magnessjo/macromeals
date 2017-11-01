
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const stripe = Stripe('pk_test_UrlLqyCEbnu4hXNhRRFaA16n');
const elements = stripe.elements();
let card;

const form = document.querySelector('form#payment');
const errorElement = document.getElementById('card-errors');
const cardNameElement = form.querySelector('#card-name-element');
const submitButton = form.querySelector('input[type="submit"]');
const costString = form.getAttribute('data-cost');
const totalCostInCents = parseInt(costString * 100);
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

        const hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'stripeToken');
        hiddenInput.setAttribute('value', result.token.id);
        form.appendChild(hiddenInput);
        form.submit();

      }

    });

  });

}

function addTokenAndSubmit(token) {

}

// Export

export default function() {

  load();
  submitForm();

  // paymentRequest.canMakePayment().then((result) => {
  //   if (result) {
  //     paymentRequestbutton.mount('#payment-request-button');
  //   } else {
  //     document.getElementById('payment-request-button').style.display = 'none';
  //   }
  // });
  //
  // paymentRequest.on('token', function(ev) {
  //   console.log(en.token.id);
  //   // addTokenAndSubmit(ev.token.id);
  // });

}
