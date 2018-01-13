
// Import

import submitToken from './submitToken.js';

// Export

export default function() {

  paypal.Button.render({

      env: 'sandbox',

      client: {
        sandbox: 'Abc9fvPP9RHFiUaZebFdLyqDxwxrrdzOFwnrJDMD0lyN1MF-OJGa9g4HkRT2i_0GxsUtjyFbviFfScBF',
        production: 'AThP6kzuAdgNgb_962Y51My9Ntg7rabWTNgr8oY_NuyPv3_H8-ah3oCjStWJ_ea_KtvJCMc-OeraMwg0'
      },

      commit: true,

      payment: function(data, actions) {
        return actions.payment.create({
          payment: {
            transactions: [{
              amount: { total: '0.01', currency: 'USD' }
            }]
          }
        });
      },

      onAuthorize: function(data, actions) {

        return actions.payment.execute().then( (token) =>  {

          if (data.paymentToken) {

            submitToken.paypal(data.paymentToken).then( (response) => {

              console.log(response);

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
      }

  }, '#paypal-button-container');

}
