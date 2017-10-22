
// import

import validation from './validation';

// Check Values At Once

function checkFormValues(input, parent, checks) {

  checks.forEach((check) => {
    validation[check](input, parent, 'blur');
  });

}

// Attach Event Listeners

function attachEventHandlers(input, parent, checks) {

  const errors = Array.from(parent.querySelectorAll('.errors p'));

  input.addEventListener('keyup', () => {

    checks.forEach((check) => {
      validation[check](input, parent, 'keydown');
    });

  });

  input.addEventListener('blur', () => {

    checks.forEach((check) => {
      validation[check](input, parent, 'blur');
    });

  });

  input.addEventListener('focus', () => {

    parent.setAttribute('has-error', false);

    errors.forEach((error) => {
      error.setAttribute('show-error', false);
    });

  });

}

const obj = {
  attachEventHandlers,
  checkFormValues,
}

export default obj;