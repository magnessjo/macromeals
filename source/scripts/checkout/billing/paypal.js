
// Import

import submitToken from './submitToken.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';

// Variables

const form = document.querySelector('#paymentMethod');
const errorElement = document.getElementById('card-errors');
const button = document.querySelector('button.paypal');
const overlay = document.querySelector('.overlay-loader');
const redirect = button.getAttribute('data-redirect');
const cancel = button.getAttribute('data-cancel');
const total = parseFloat(button.getAttribute('data-total'));

// Error Handling

function handleError(error) {

  overlay.style.display = 'none';

  errorElement.innerHTML = `
    <p>${error}</p>
    <p>Your cart has been saved.  Please contact our support team at <a href="help@macromeals.life">help@macromeals.life</a> to process your payment.</p>
  `;

  errorElement.style.display = 'block';
  scrollToLocation(errorElement, 40);

}

// Export

export default function() {

  paypal.Button.render({

    env: 'sandbox',

    client: {
      sandbox:    'Abc9fvPP9RHFiUaZebFdLyqDxwxrrdzOFwnrJDMD0lyN1MF-OJGa9g4HkRT2i_0GxsUtjyFbviFfScBF',
      production: 'ATK4NKzbdpsi2ziukYr69y9rwDbCTfoRcng35fZaAg07MWJ0sE-RV1CR6ULLvhRW6CkKHn00-GwRueyA'
    },

    commit: true,

    style: {
      color: 'black',
      size: 'medium',
      shape: 'rect',
    },

    payment: function(data, actions) {

      return actions.payment.create({
        payment: {
          transactions: [{
            amount: { total: total, currency: 'USD' },
          }]
        }
      });

    },

    onAuthorize: function(data, actions) {

      console.log(data);
      console.log(actions);

      submitToken.paypal(data, redirect, cancel).then( (response) => {

        console.log(response);
        if (response.error) handleError(response.error)

      });

    },

    onError: function(error) {
      handleError(response.error);
    },

  }, '#paypal-submit');

}
