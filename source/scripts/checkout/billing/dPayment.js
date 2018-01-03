
// Imports

import fetchPostData from 'scripts/helpers/fetchPostData.js';

// Variables

const form = document.querySelector('form#dummy');
const inputs = Array.from(form.querySelectorAll('input[type="text"]'));
const submitButton = form.querySelector('input[type="submit"]');

// Export

export default function() {

  form.addEventListener('submit', (e) => {

    e.preventDefault();
    submitButton.disabled = true;

    let post = `${window.csrfTokenName}=${window.csrfTokenValue}&paymentMethodId=3&`;

    inputs.forEach( (input, i) => {

      const name = input.getAttribute('name');
      const value = input.value;

      post += `${name}=${value}`;
      if (i != inputs.length - 1) post += '&';

    });

    console.log(post);

    fetchPostData(post, '/actions/commerce/payments/pay').then( (response) => {
      console.log(response);

      if (response.success) {
        window.location.href = '/checkout/complete';
      }

      if (response.error) {

        submitButton.disabled = false;

        errorElement.innerHTML = `
          <p>${response.error}</p>
          <p>Your cart has been saved.  Please contact our support team at <a href="help@macromeals.life">help@macromeals.life</a> to process your payment.</p>
        `;

        errorElement.style.display = 'block';
      }

    });

  });

}
