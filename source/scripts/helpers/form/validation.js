
// Show Error

function displayError(errorElement, parent) {

  errorElement.setAttribute('show-error', true);
  parent.setAttribute('valid', false);
  parent.setAttribute('has-error', true);

}

// Remove Error

function hideError(errorElement, parent) {

  errorElement.setAttribute('show-error', false);
  parent.setAttribute('valid', true);
  parent.setAttribute('has-error', false);

}

// Check for a Password

function checkForPassword(input, parent) {

  const hasErrors = parent.getAttribute('has-error');
  const errors = parent.querySelector('.errors');
  const passwordError = errors.querySelector('.password');
  const value = input.value;

  if (hasErrors == 'true') return;

  if (value.length > 7) {
    hideError(passwordError, parent);
  } else {
    displayError(passwordError, parent);
  }

}

// Check for a Letter

function checkForLetter(input, parent) {

  const hasErrors = parent.getAttribute('has-error');
  const errors = parent.querySelector('.errors');
  const letterError = errors.querySelector('.letters');
  const reg = new RegExp('^[a-zA-Z]+$');
  const value = input.value;

  if (hasErrors == 'true') return;

  if (reg.test(value) == true) {
    hideError(letterError, parent);
  } else {
    displayError(letterError, parent);
  }

}

// Check for Required

function required(input, parent) {

  const errors = parent.querySelector('.errors');
  const allErrors = Array.from(errors.querySelectorAll('p'));
  const requiredError = errors.querySelector('.required');
  const length = input.value.length;

  if (length > 0) {
    hideError(requiredError, parent);
  } else {
    displayError(requiredError, parent);
    allErrors.forEach((error) => {
      if (error == requiredError) return;
      error.setAttribute('show-error', false);
    });
  }

}

const obj = {
  checkForPassword,
  checkForLetter,
  required,
}

export default obj;
