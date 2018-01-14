
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import submitToken from './submitToken.js';

// Variables

const form = document.querySelector('form#payment');
const errorElement = document.getElementById('card-errors');
const cardNameElement = form.querySelector('#card-name-element');
const submitButton = form.querySelector('input[type="submit"]');
const loader = document.querySelector('.overlay-loader');

const style = {
  base: {
    iconColor: '#000',
    color: '#000',
    fontFamily: 'acumin-pro, arial, sans-serif',
    fontWeight: 400,
  },
}

// Export

export default function(stripeRef, elementsRef) {

  const stripe = stripeRef;
  const elements = elementsRef;
  const cardNumberElement = elements.create('cardNumber', { style: style });
  const cardExpiryElement = elements.create('cardExpiry', { style: style });
  const cardCvcElement = elements.create('cardCvc', { style: style });
  const postalCodeElement = elements.create('postalCode', { style: style });
  const inputs = [ cardNumberElement, cardExpiryElement, cardCvcElement, postalCodeElement ];
  const card = cardNumberElement;

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

  form.addEventListener('submit', e => {

    const nameInput = cardNameElement.querySelector('input');

    e.preventDefault();
    submitButton.disabled = true;
    loader.style.display = 'block';

    stripe.createToken(card, {
      name : nameInput.value,
      address_country: 'US',
    }).then( (result) => {

      if (result.error) {

        submitButton.disabled = false;
        loader.style.display = 'none';

        errorElement.innerHTML = `
          <p>${result.error.message}</p>
          <p>If you feel that this error is incorrect:  Please contact our support team at <a href="help@macromeals.life">help@macromeals.life</a></p>
        `;

        errorElement.style.display = 'block';

      } else {

        submitToken.stripe(result.token.id).then( (response) => {

          if (response.error) {

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


    });

  });

}
