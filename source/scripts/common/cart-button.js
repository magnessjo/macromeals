
// Import

import getCartItems from 'scripts/helpers/cart/getCartItems.js';

// Variables

const header = document.querySelector('header');
const button = header.querySelector('.cart');
const cartSummary = header.querySelector('.cart-summary');
const loginForm = header.querySelector('.login-form');
const wrapper = cartSummary.querySelector('.order-items');
const actionLink = cartSummary.querySelector('.call-to-action');

// Update DOM

function updateDOM(data) {

  return new Promise((resolve, reject) => {

    if (data.length == 0) {
      wrapper.innerHTML = `<p>Your Cart is Empty</p>`;
      actionLink.style.display = 'none';
      resolve();
    }

    data.sort( (a, b) => {
       return a.title.localeCompare(b.title);
    });

    data.forEach((content, i) => {

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
      actionLink.style.display = 'block';

      if (i == data.length - 1) {
        resolve();
      }

    });

  });

}

// Remove content

function removeContent() {

  return new Promise((resolve, reject) => {

    wrapper.innerHTML = '';
    resolve();

  });

}

// Export Function

export default function() {

  button.addEventListener('click', () => {

    const isShown = cartSummary.getAttribute('aria-hidden');

    if (isShown == 'true') {

      getCartItems().then((data) => {
        updateDOM(data).then(() => {
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
