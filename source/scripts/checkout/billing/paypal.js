
// Import

import submitToken from './submitToken.js';

// Variables

const form = document.querySelector('#paymentMethod');
const costString = form.getAttribute('data-cost');
const environment = window.location.origin == 'https://www.macromeals.life' ? 'production' : 'sandbox';

// Export

export default function() {

  paypal.Button.render({

      env: environment,

      client: {
        sandbox: 'Abc9fvPP9RHFiUaZebFdLyqDxwxrrdzOFwnrJDMD0lyN1MF-OJGa9g4HkRT2i_0GxsUtjyFbviFfScBF',
        production: 'AThP6kzuAdgNgb_962Y51My9Ntg7rabWTNgr8oY_NuyPv3_H8-ah3oCjStWJ_ea_KtvJCMc-OeraMwg0'
      },

      commit: true,

      style: {
        size: 'medium',
        color: 'gold',
        shape: 'rect',
      },

      payment: function(data, actions) {
        return actions.payment.create({
          payment: {
            transactions: [{
              amount: { total: costString, currency: 'USD' }
            }]
          }
        });
      },

      onAuthorize: function(data, actions) {

        return actions.payment.execute().then( (token) =>  {

          if (data.paymentToken) {

            submitToken.paypal(data.paymentID).then( (response) => {

              if (response.error) {

                errorElement.innerHTML = `
                  <p>${response.error}</p>
                  <p>Your cart has been saved.  Please contact our support team at <a href="help@macromeals.life">help@macromeals.life</a> to process your payment.</p>
                `;

                errorElement.style.display = 'block';
              }

            });

          }

        });
      }

  }, '#paypal-button-container');

}
