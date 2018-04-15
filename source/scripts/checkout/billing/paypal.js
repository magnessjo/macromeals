
// Import

import submitToken from './submitToken.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';

// Variables

const form = document.querySelector('#paymentMethod');
const errorElement = document.getElementById('card-errors');
const container = document.querySelector('.paypal');
const button = container.querySelector('button');
const overlay = document.querySelector('.overlay-loader');
const redirect = button.getAttribute('data-redirect');
const cancel = button.getAttribute('data-cancel');

// Export

export default function() {

  button.addEventListener('click', e => {

    e.preventDefault();

    button.disabled = true;
    overlay.style.display = 'block';

    submitToken.paypal(redirect, cancel).then( (response) => {

      console.log(response);

      if (response.error) {

        button.disabled = false;
        overlay.style.display = 'none';

        errorElement.innerHTML = `
          <p>${response.error}</p>
          <p>Your cart has been saved.  Please contact our support team at <a href="help@macromeals.life">help@macromeals.life</a> to process your payment.</p>
        `;

        errorElement.style.display = 'block';
        scrollToLocation(errorElement, 40);
      }

    });

  });

}
