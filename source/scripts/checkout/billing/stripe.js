
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import fetchPostData from 'scripts/helpers/fetchPostData.js';

// Variables

const stripe = window.location.origin == 'https://www.macromeals.life' ? Stripe('pk_live_5eXACjQVrzeUQpCpF0ydV15h') : Stripe('pk_test_UrlLqyCEbnu4hXNhRRFaA16n');
const elements = stripe.elements();

const form = document.querySelector('form#payment');
const errorElement = document.getElementById('card-errors');
const cardNameElement = form.querySelector('#card-name-element');
const submitButton = form.querySelector('input[type="submit"]');
const loader = form.querySelector('.loader');

const style = {
  base: {
    iconColor: '#000',
    color: '#000',
    fontFamily: 'acumin-pro, arial, sans-serif',
    fontWeight: 400,
  },
}

const cardNumberElement = elements.create('cardNumber', { style: style });
const cardExpiryElement = elements.create('cardExpiry', { style: style });
const cardCvcElement = elements.create('cardCvc', { style: style });
const postalCodeElement = elements.create('postalCode', { style: style });
const inputs = [ cardNumberElement, cardExpiryElement, cardCvcElement, postalCodeElement ];
const card = cardNumberElement;

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

  form.addEventListener('submit', (e) => {

    const nameInput = cardNameElement.querySelector('input');

    e.preventDefault();
    submitButton.disabled = true;
    loader.style.display = 'block';

    stripe.createToken(card, {
      name : nameInput.value,
      address_country: 'US',
    }).then((result) => {
      addTokenAndSubmit(result.token.id);
    });

  });

}
