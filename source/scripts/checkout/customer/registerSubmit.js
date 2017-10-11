
// Import

import slider from './slider.js';
import fetchData from 'scripts/helpers/fetchPostData.js';

// Variables

const form = document.querySelector('form#user-info');
const inputs = Array.from(form.querySelectorAll('input'));

// Function submit

function submitForm(e) {

  e.preventDefault();

  const data = `user=test&email=test@test.com&password=test`;

  fetchData(data, '/actions/users/saveUser').then((response) => {

    if (response.errors) {

      const value = response.errors;
      const slide = form.parentNode;
      const slider = slide.parentNode;

      for (const key in value) {

        const elm = form.querySelector(`input[name="${key}"]`);
        const parent = elm.parentNode;
        const errorElm = document.createElement('p');

        errorElm.classList = 'error';
        errorElm.innerHTML = value[key];

        parent.appendChild(errorElm);

        slider.style.height = `${slide.offsetHeight}px`;

      }

    } else {
      slider(1, true);
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
