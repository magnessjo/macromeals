
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';
import validation from 'scripts/helpers/form/validation.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const form = document.querySelector('form#contact');

const firstNameInput = form.querySelector('input[name="firstName"]');
const lastNameInput = form.querySelector('input[name="lastName"]');
const emailInput = form.querySelector('input[name="email"]');
const phoneInput = form.querySelector('input[name="phone"]');

const firstNameParent = findParentNode(firstNameInput, 'field');
const lastNameParent = findParentNode(lastNameInput, 'field');
const emailParent = findParentNode(emailInput, 'field');
const phoneParent = findParentNode(phoneInput, 'field');

const confirmation = document.querySelector('.confirmation');
const inputs = [firstNameInput, lastNameInput, emailInput, phoneInput];

// Function submit

function submitForm(e) {

  let data = `${window.csrfTokenName}=${window.csrfTokenValue}&`;

  inputs.forEach((input, i) => {
    const name = input.getAttribute('name');
    const value = encodeURIComponent(input.value);
    data += `${name}=${value}`;
    if (inputs.length - 1 != i) data += '&';
  });

  fetchData(data, '/actions/users/saveUser').then( (response) => {

  });

}

// Export

export default function() {

  // Add Event Listeners

  firstNameInput.addEventListener('blur', () => {
    validation.required(firstNameInput, firstNameParent);
  });

  lastNameInput.addEventListener('blur', () => {
    validation.required(lastNameInput, lastNameParent);
  });

  emailInput.addEventListener('blur', () => {
    validation.required(emailInput, emailParent);
    validation.checkForEmail(emailInput, emailParent);
  });

  phoneInput.addEventListener('blur', () => {
    validation.required(phoneInput, phoneParent);
  });

  inputs.forEach((input) => {
    input.addEventListener('focus', () => {
      const parent = findParentNode(input, 'field');
      const elements = Array.from(parent.querySelectorAll('.errors p'));
      elements.forEach( (elm) => { elm.style.display = 'none'} );
    });
  });

  // Form Submit Action

  form.addEventListener('submit', (e) => {

    e.preventDefault();
    validation.required(firstNameInput, firstNameParent);
    validation.required(lastNameInput, lastNameParent);
    validation.required(emailInput, emailParent);
    validation.checkForEmail(emailInput, emailParent);
    validation.required(phoneInput, phoneParent);

    const firstNameValid = firstNameParent.getAttribute('valid');
    const lastNameValid = lastNameParent.getAttribute('valid');
    const emailValid = emailParent.getAttribute('valid');
    const phoneValid = phoneParent.getAttribute('valid');

    if (firstNameValid == 'true' && lastNameValid == 'true' && emailValid == 'true' && phoneValid == 'true') {
      submitForm();
    }

  });

}
