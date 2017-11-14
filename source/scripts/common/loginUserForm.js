
// Imports

import postLogin from 'scripts/helpers/user/postLogin.js';
import validation from 'scripts/helpers/form/validation.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const header = document.querySelector('header');
const loginForm = header.querySelector('#login-form');
const userNameInput = loginForm.querySelector('input[name="loginName"]');
const passwordInput = loginForm.querySelector('input[name="password"]');
const rememberUser = loginForm.querySelector('input[name="rememberMe"]');
const userNameParent = findParentNode(userNameInput, 'field');
const passwordParent = findParentNode(passwordInput, 'field');
const craftErrors = loginForm.querySelector('.craft-errors');

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

  rememberUser.addEventListener('change', () => {
    const isChecked = rememberUser.checked;
    isChecked ? rememberUser.value = 1 : rememberUser.value = 0;
  });

  userNameInput.addEventListener('focus', () => {
    craftErrors.innerHTML = '';
  });

  passwordInput.addEventListener('focus', () => {
    craftErrors.innerHTML = '';
  });

  // Submit Form

  loginForm.addEventListener('submit', (e) => {

    e.preventDefault();
    validation.required(userNameInput, userNameParent);
    validation.required(passwordInput, passwordParent);
    validation.checkForPassword(passwordInput, passwordParent);

    const userValid = userNameParent.getAttribute('valid');
    const passwordValid = passwordParent.getAttribute('valid');

    if (userValid != 'true' || passwordValid != 'true') {
      validation.required(userNameInput, userNameParent);
      validation.required(passwordInput, passwordParent);
      validation.checkForPassword(passwordInput, passwordParent);
      return;
    } else {

      const userdata = `
        ${window.csrfTokenName}=${window.csrfTokenValue}&loginName=${userNameInput.value}&password=${passwordInput.value}&rememberMe=${rememberUser.value}
      `;

      postLogin(userdata).then( (response) => {

        if (response.error) {

          const element = document.createElement('p');
          element.innerHTML = response.error;
          element.style.display = 'block';
          craftErrors.style.display = 'block';
          craftErrors.appendChild(element);

        } else {
          const body = document.querySelector('body');
          const parent = loginForm.parentNode;
          body.setAttribute('logged-in', true);
          parent.setAttribute('aria-hidden', true);

          if (window.location.pathname = "account/checkout-login") {
            window.location.pathname = 'checkout';
          }

        }

      });

    }

  });

}
