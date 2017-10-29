
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

function billingZipCodeInput() {

  const container = form.querySelector('.zip');
  const input = container.querySelector('input');
  const invalidError = errors.querySelector('.zip');

  input.addEventListener('blur', () => {

    const isLength = input.value.length == 5;
    !isLength ? showError(container, invalidError) : hideError(container, invalidError)

  });

}

function cvcInput() {

  const container = form.querySelector('.zip');
  const input = container.querySelector('input');
  const invalidError = errors.querySelector('.zip');

  input.addEventListener('blur', () => {

    const isLength = input.value.length == 5;
    !isLength ? showError(container, invalidError) : hideError(container, invalidError)

  });

}

function cvcInput() {

  const container = form.querySelector('.cvc');
  const input = container.querySelector('input');
  const invalidError = errors.querySelector('.cvc');

  input.addEventListener('blur', () => {

    const length = input.value;

    if (length != 3 || length != 4) {
      showError(container, invalidError);
    } else {
      hideError(container, invalidError)
    }

  });

}

function cardNumberInput() {

  const container = form.querySelector('.number');
  const input = container.querySelector('input');
  const invalidError = errors.querySelector('.number');

  const visaReg =  /^4/;
  const amexReg = /^3[47]/;
  const discovRegEx = /^(6011|65|64[4-9]|622)/;
  const mastercardRegEx = /^(5[1-5]|677189)|^(222[1-9]|2[3-6]\d{2}|27[0-1]\d|2720)/;
  let cardType = '';

  input.addEventListener('keyup', (e) => {

    const value = input.value;
    const length = value.length;

    const isVisa = visaReg.test(value);
    const isAmex = amexReg.test(value);
    const isDisover = discovRegEx.test(value);
    const isMaster = mastercardRegEx.test(value);

    if (!isVisa && !isAmex && !isDisover && !isMaster) {
      cardType = '';
    } else {
      if (isAmex) cardType = 'amex';
      if (isVisa) cardType = 'visa';
      if (isDisover) cardType = 'discover';
      if (isMaster) cardType = 'master';
    }

    if (cardType != '') container.setAttribute('card-type', cardType);


  });

  input.addEventListener('blur', () => {


  });

}

// Export

export default function() {

  cardNumberInput();
  expirationInput();
  billingZipCodeInput();
  cvcInput();
  inputs.forEach((input) => { checkOverlay(input) });

}
