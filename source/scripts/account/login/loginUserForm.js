
// Imports

import postLogin from 'scripts/helpers/user/postLogin.js';
import validation from 'scripts/helpers/form/validation.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const loginForm = document.querySelector('#login-form');
const userNameInput = loginForm.querySelector('input[name="loginName"]');
const passwordInput = loginForm.querySelector('input[name="password"]');
const rememberUser = loginForm.querySelector('input[type="checkbox"]');
const userNameParent = findParentNode(userNameInput, 'field');
const passwordParent = findParentNode(passwordInput, 'field');
const craftError = loginForm.querySelector('.craft-error');

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
      loginForm.submit();
    }

    // userdata = `
    //   ${window.csrfTokenName}=${window.csrfTokenValue}&
    //   loginName=${userNameInput.value}&
    //   password=${passwordInput.value}
    // `;
    //
    // postLogin(userdata).then((response) => {
    //   if (response.error) {
    //     craftError.innerHTML = `${response.error}`;
    //     console.log(response);
    //   } else {
    //
    //   }
    //
    // });

  });

}
