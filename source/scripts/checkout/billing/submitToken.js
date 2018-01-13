
// Imports

import fetchPostData from 'scripts/helpers/fetchPostData.js';

// Stripe

function stripe(token) {

  return new Promise( (resolve, reject) => {

    fetchPostData(`${window.csrfTokenName}=${window.csrfTokenValue}&paymentMethodId=2&stripeToken=${token}`, '/actions/commerce/payments/pay').then( (response) => {

      if (response.success) {

        window.location.href = '/checkout/complete';
        resolve(response);

      } else {
        console.log(response);
        resolve(response);

      }

    });

  });

}


const obj = {
  stripe,
}

export default obj;
