
// Check for a Number

function checkForNumber(value) {

  const reg = new RegExp('^[0-9]+$');

  if (reg.test(value) == false) return true;

  return false;

}

// Check for Zero value

function checkForZeroValue(value) {

  if (value == 0) return true;

  return false;

}

// Check for a Letter

function checkForLetter(input, parent, showError) {

  const hasErrors = parent.getAttribute('valid');
  const errors = parent.querySelector('.errors');
  const letterError = errors.querySelector('.letters');
  const reg = new RegExp('^[a-zA-Z]+$');

  if (hasErrors) return;

  function checkValue(type) {

    const value = input.value;

    if (reg.test(value) == false) {
      letterError.setAttribute('show-error', false);
    } else {

      if (type != 'focus') {
        letterError.setAttribute('show-error', true);
      }

    }

  }

  if (showError) checkValue();

  input.addEventListener('blur', () => checkValue('blur'));
  input.addEventListener('focus', () => checkValue('focus'));

}

// Check for Length

function required(input, parent, showError) {

  const isRequired = parent.getAttribute('data-required');
  const errors = parent.querySelector('.errors');
  const requiredError = errors.querySelector('.required');

  function checkValue(type) {

    const length = input.value.length;

    if (isRequired != null) {

      if (length > 0) {
        requiredError.setAttribute('show-error', false);
        parent.setAttribute('valid', false);
      } else {

        if (type != 'focus') {
          requiredError.setAttribute('show-error', true);
          parent.setAttribute('valid', true);
        }

      }

    }

  }

  if (showError) checkValue();

  input.addEventListener('blur', () => checkValue('blur'));
  input.addEventListener('focus', () => checkValue('focus'));
  input.addEventListener('change', () => checkValue('change'));

}

const obj = {
  checkForNumber,
  checkForZeroValue,
  checkForLetter,
  required,
}

export default obj;
