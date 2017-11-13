
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';
import validation from 'scripts/helpers/form/validation.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const registerForm = document.querySelector('form#user-info');
const userNameInput = registerForm.querySelector('input[name="username"]');
const passwordInput = registerForm.querySelector('input[name="password"]');
const emailInput = registerForm.querySelector('input[name="email"]');
const userNameParent = findParentNode(userNameInput, 'field');
const passwordParent = findParentNode(passwordInput, 'field');
const emailParent = findParentNode(emailInput, 'field');
const craftError = registerForm.querySelector('.craft-errors');
const confirmation = document.querySelector('.regiseration-confirmation');
const inputs = [userNameInput, passwordInput, emailInput];

// Function submit

function submitForm(e) {

  let data = `${window.csrfTokenName}=${window.csrfTokenValue}&`;

  inputs.forEach((input, i) => {
    const name = input.getAttribute('name');
    const value = encodeURIComponent(input.value);
    data += `${name}=${value}`;
    if (inputs.length - 1 != i) data += '&';
  });

  console.log(data);

  fetchData(data, '/actions/users/saveUser').then((response) => {

    console.log(response);

    if (response.errors) {

      const errors = response.errors;

      for (let key in errors) {

        const error = errors[key];
        const element = registerForm.querySelector(`input[name="${key}"]`);
        const parent = findParentNode(element, 'field');
        const errorElement = parent.querySelector('.errors');
        parent.setAttribute('has-error', true);

        error.forEach((text) => {
          const element = document.createElement('p');
          element.innerHTML = text;
          element.style.display = 'block';
          errorElement.appendChild(element);
        });

        craftError.style.display = 'block';

      }

    } else {

      const body = document.querySelector('body');

      registerForm.style.display = 'none';
      confirmation.style.display = 'block';
      body.setAttribute('logged-in', true);

    }

  });

}

// Export

export default function() {

  // Add Event Listeners

  userNameInput.addEventListener('blur', () => {
    validation.required(userNameInput, userNameParent);
  });

  passwordInput.addEventListener('blur', () => {
    validation.required(passwordInput, passwordParent);
    validation.checkForPassword(passwordInput, passwordParent);
  });

  emailInput.addEventListener('blur', () => {
    validation.required(emailInput, emailParent);
    validation.checkForEmail(emailInput, emailParent);
  });

  inputs.forEach((input) => {
    input.addEventListener('focus', () => {
      const parent = findParentNode(input, 'field');
      const elements = Array.from(parent.querySelectorAll('.errors p'));
      elements.forEach( (elm) => { elm.style.display = 'none'} );
    });
  });

  // Form Submit Action

  registerForm.addEventListener('submit', (e) => {

    e.preventDefault();
    validation.required(userNameInput, userNameParent);
    validation.required(passwordInput, passwordParent);
    validation.checkForPassword(passwordInput, passwordParent);
    validation.required(emailInput, emailParent);
    validation.checkForEmail(emailInput, emailParent);

    const userValid = userNameParent.getAttribute('valid');
    const passwordValid = passwordParent.getAttribute('valid');
    const emailValid = emailParent.getAttribute('valid');

    if (userValid == 'true' && passwordValid == 'true' && emailValid == 'true') {
      submitForm();
    }

  });

}
