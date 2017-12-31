
// Imports

import fetchPostData from 'scripts/helpers/fetchPostData.js';

// Variables

const form = document.querySelector('form#dummy');
const inputs = Array.from(form.querySelectorAll('input[type="text"]'));

// Export

export default function() {

  form.addEventListener('submit', (e) => {

    e.preventDefault();

    let post = `${window.csrfTokenName}=${window.csrfTokenValue}&`;

    inputs.forEach( (input, i) => {

      const name = input.getAttribute('name');
      const value = input.value;

      post += `${name}=${value}`;
      if (i != inputs.length - 1) post += '&';

    });

    fetchPostData(post, '/actions/commerce/payments/pay').then( (response) => {
      console.log(response);
    });

  });

}
