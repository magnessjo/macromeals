
// Import

import postToCart from 'scripts/helpers/cart/postToCart.js';
import updateCartTotals from 'scripts/helpers/cart/updateCartTotals.js';

// Variables

const section = document.querySelector('#cart-total');
const container = section.querySelector('.promo');
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

    console.log(postData);

    postToCart(postData).then( (data) => {

      const cart = data.cart;
      const discount = cart.baseDiscount;

      discountElement.innerHTML = `($${discount})`;

      updateCartTotals(cart);
      parent.style.display = 'block';
      button.innerHTML = 'change';

    });

  });

}
