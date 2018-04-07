
// Import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import updateCartItem from 'scripts/helpers/cart/updateCartItem.js';
import updateCartTotals from 'scripts/helpers/cart/updateCartTotals.js';

// Variables

const container = document.querySelector('.cooler-club');
const cartTotal = document.querySelector('#cart-total');

// Export

export default function() {

  if (container) {

    const button = container.querySelector('button');

    button.addEventListener('click', (e) => {

      const isAdjusted = button.getAttribute('data-adjustment');

      e.preventDefault();
      button.disabled = true;

      if (isAdjusted != 'true') {
        button.innerHTML = 'Apply';
        button.setAttribute('data-adjustment', true);
      } else {
        button.innerHTML = 'Remove';
        button.setAttribute('data-adjustment', false);
      }

      let data = `${window.csrfTokenName}=${window.csrfTokenValue}&apply=${isAdjusted}`;

      fetchPostData(data, '/coolerClub').then((response) => {

        button.disabled = false;

        if (response.success) {

          const firstItem = document.querySelectorAll('.order-item')[0];
          const itemId = firstItem.getAttribute('data-id');
          const qty = document.querySelector('.item-actions span').innerHTML;

          data += `&lineItemId=${itemId}&qty=${qty}`;

          updateCartItem(data).then( (response) => {

            if (response.success) {
              updateCartTotals(response.cart);
            } else {
              console.log(response);
            }

          });

        } else {
          console.log(response);
        }

      });

    });

  }

}
