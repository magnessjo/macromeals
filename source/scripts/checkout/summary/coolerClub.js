
// Import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import postToCart from 'scripts/helpers/cart/postToCart.js';
import updateCartTotals from 'scripts/helpers/cart/updateCartTotals.js';

// Variables

const container = document.querySelector('.cooler-club');
const cartTotal = document.querySelector('#cart-total');

// Export

export default function() {

  if (container) {

    const button = container.querySelector('button');

    button.addEventListener('click', (e) => {

      e.preventDefault();

      let data = `${window.csrfTokenName}=${window.csrfTokenValue}`;

      fetchPostData(data, '/actions/MacroCommerce/Cart/setCoolerClub').then((response) => {

        if (response.success) {

          const shippingElement = cartTotal.querySelector('[data-type="shipping-amount"]');
          const totalElement = cartTotal.querySelector('[data-type="total-amount"]');
          const totalCost = totalElement.innerHTML;
          const costString = totalCost.replace(/[^0-9.]/g, '');
          const cost = costString - 10.00;

          shippingElement.innerHTML = '0.00';
          totalElement.innerHTML = `$${cost}`;
          button.disabled = true;

        } else {
          console.log(response);
        }

      });

    });

  }

}
