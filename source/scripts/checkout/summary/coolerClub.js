
// Import

import postToCart from 'scripts/helpers/cart/postToCart.js';
import updateCartTotals from 'scripts/helpers/cart/updateCartTotals.js';

// Variables

const container = document.querySelector('.cooler-club');

// Export

export default function() {

  if (container) {

    const button = container.querySelector('button');

    button.addEventListener('click', (e) => {

      e.preventDefault();

      let postData = `${window.csrfTokenName}=${window.csrfTokenValue}`;

      postToCart(postData).then( (data) => {

        console.log(data);

        const cart = data.cart;

      });

    });

  }

}
