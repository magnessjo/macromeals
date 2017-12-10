
// Import

import postToCart from 'scripts/helpers/cart/postToCart.js';
import updateCartTotals from 'scripts/helpers/cart/updateCartTotals.js';

// Variables

const section = document.querySelector('#cart-total');
const container = section.querySelector('.promo');
const error = container.querySelector('.promo-error');
const button = container.querySelector('button');
const input = container.querySelector('input[type="text"]');
const text = container.querySelector('.text');
const discountElement = section.querySelector('[data-type="discount-amount"]');
const parent = discountElement.parentNode;

// Export

export default function() {

  button.addEventListener('click', (e) => {

    e.preventDefault();

    const discountApplied = button.getAttribute('data-discount');
    const value = input.value;
    const name = input.getAttribute('name');
    let postData = `${window.csrfTokenName}=${window.csrfTokenValue}`;

    if (discountApplied) {
      postData += `&${name}=""`;
    } else {
      postData += `&${name}=${value}`;
    }

    postToCart(postData).then( (data) => {

      if (data.error) {
        error.style.display = 'block';
      } else {

        const cart = data.cart;
        const adjustments = cart.adjustments;
        const discounts = typeof adjustments !== 'undefined' ? adjustments.Discount : 'undefined';

        error.style.display = 'none';

        if (typeof discounts !== 'undefined') {
          const discount = adjustments.Discount[0].amount;
          discountElement.innerHTML = `(${discount.toFixed(2)})`;
          updateCartTotals(cart);
          parent.style.display = 'block';
          button.innerHTML = 'change';
        }

      }

    });

  });

}
