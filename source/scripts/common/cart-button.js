
// Import

import getCartItems from 'scripts/helpers/cart/getCartItems.js';

// Variables

const header = document.querySelector('header');
const button = header.querySelector('.cart');
const cartSummary = header.querySelector('.cart-summary');
const loginForm = header.querySelector('.login-form');
const wrapper = cartSummary.querySelector('.order-items');
const headerCartActions = cartSummary.querySelector('.header-cart-actions');

// Update DOM

function updateDOM(items) {

  return new Promise( (resolve, reject) => {

    if (items.length == 0) {
      wrapper.innerHTML = `<p class="cart-alert">Your Cart is Empty</p>`;
      headerCartActions.style.display = 'none';
      resolve();
    }

    items.sort( (a, b) => {
       return a.title.localeCompare(b.title);
    });

    items.forEach( (content, i) => {

      const div = document.createElement('div');
      const headline = document.createElement('h2');
      const span = document.createElement('span');

      div.classList.add('order-item');

      headline.innerHTML = content.title;
      span.innerHTML = content.size;

      headline.setAttribute('data-attr', content.quantity);

      headline.appendChild(span);
      div.appendChild(headline);
      wrapper.appendChild(div);
      headerCartActions.style.display = 'block';

      if (i == items.length - 1) {
        resolve();
      }

    });

  });

}

// Remove content

function removeContent() {

  return new Promise( (resolve, reject) => {

    wrapper.innerHTML = '';
    resolve();

  });

}

// Export Function

export default function() {

  button.addEventListener('click', () => {

    const isShown = cartSummary.getAttribute('aria-hidden');

    if (isShown == 'true') {

      getCartItems().then( (data) => {
        updateDOM(data.items).then( e => {
          cartSummary.setAttribute('aria-hidden', 'false');
          loginForm.setAttribute('aria-hidden', 'true')
        });
      });

    } else {

      removeContent().then(() => {
        cartSummary.setAttribute('aria-hidden', 'true');
      });

    }

  });

}
