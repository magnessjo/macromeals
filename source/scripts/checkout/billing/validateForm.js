
// Import

import parentNode from 'scripts/helpers/findParentNode.js';

// Variables

const form = document.querySelector('form');
const errors = form.querySelector('.errors');
const inputs = Array.from(form.querySelectorAll('input[type="text"]'));

// Add Overlay

function checkOverlay(input) {

  const parent = parentNode(input, 'field');
  const overlay = parent.querySelector('.overlay');
  let overlayShowing = false;

  input.addEventListener('keyup', (e) => {

    if (input.value.length > 0 && !overlayShowing) {
      overlay.style.display = 'block';
      overlayShowing = true;
    }

    if (input.value.length == 0 && overlayShowing) {
      overlay.style.display = 'none';
      overlayShowing = false;
    }

  });

}

// Show Error

function showError(container, error) {
  console.log(container);
  container.setAttribute('valid', false);
  container.setAttribute('has-error', true);
  error.setAttribute('show-error', true);
}

function hideError(container, error) {
  container.setAttribute('valid', true);
  container.setAttribute('has-error', false);
  error.setAttribute('show-error', false);
}

function expirationInput() {

  const container = form.querySelector('.expiration');
  const input = container.querySelector('input');
  const hiddenMonth = form.querySelector('[data-stripe="exp_month"]');
  const hiddenYear = form.querySelector('[data-stripe="exp_year"]');
  const expiredError = errors.querySelector('.expired');


  input.addEventListener('keypress', (e) => {

    if (input.value.length == 2 && e.keyCode == 47) return;

    if (input.value.length == 2) {
      input.value = input.value + '/';
    }

  });

  input.addEventListener('blur', () => {

    const isLength = input.value.length == 5;

    if (!isLength) {
      showError(container, expiredError);
      return;
    }

    const stringArray = input.value.split('/');
    const month = parseInt(stringArray[0]);
    const year = parseInt(stringArray[1]);
    const today = new Date();
    const expirationDate = new Date(`20${year}`, month, 1);

    if (month > 12) {
      showError(container, expiredError);
      return;
    }

    if (today > expirationDate) {
      showError(container, expiredError);
    } else {
      hideError(container, expiredError);
      hiddenMonth.value = month;
      hiddenYear.value = year;
    }

  });

}

// Export

export default function() {

  expirationInput();
  inputs.forEach((input) => { checkOverlay(input) });

}
