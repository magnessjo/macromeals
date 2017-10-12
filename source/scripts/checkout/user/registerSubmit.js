
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Variables

const form = document.querySelector('form#user-info');
const inputs = Array.from(form.querySelectorAll('input[type="text"]'));

// Function submit

function submitForm(e) {

  e.preventDefault();

  let data = `${window.csrfTokenName}=${window.csrfTokenValue}&`;

  inputs.forEach((input, i) => {
    const value = input.value;
    const name = input.getAttribute('name');
    data += `${name}=${value}`;
    if (inputs.length - 1 != i) data += '&';
  });

  fetchData(data, '/actions/users/saveUser').then((response) => {

    if (response.errors) {

      const value = response.errors;

      for (const key in value) {

        const elm = form.querySelector(`input[name="${key}"]`);
        const parent = elm.parentNode;
        const errorElm = document.createElement('p');

        errorElm.classList = 'error';
        errorElm.innerHTML = value[key];

        parent.appendChild(errorElm);

      }

    } else {
      window.location.href = '/checkout';
    }

  });

}

// Export

export default function() {

  form.addEventListener('submit', (e) => { submitForm(e) });

  inputs.forEach((input) => {

    input.addEventListener('focus', () => {
      const parent = input.parentNode;
      const errors = Array.from(parent.querySelectorAll('.error'));

      errors.forEach((error) => { error.remove() });
    });

  });

}
