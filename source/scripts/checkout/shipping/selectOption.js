
// Imports

import postToCart from 'scripts/helpers/cart/postToCart.js';

// Variables

const form = document.querySelector('form#shipping-selection');

// Export

export default function() {

  if (form) {

    const links = Array.from(form.querySelectorAll('.call-to-action'));

    links.forEach( (link) => {

      link.addEventListener('click', (e) => {

        e.preventDefault();
        const href = link.getAttribute('href');
        const option = link.getAttribute('data-option');
        let data = `${window.csrfTokenName}=${window.csrfTokenValue}&`;

        data += `shippingMethod=${option}`

        postToCart(data).then( (response) => {
          window.location.href = href;
        });

      });

    });

  }


}
