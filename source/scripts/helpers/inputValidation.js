
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

function checkForLetter(input, parent) {

  const errors = parent.querySelector('.errors');
  const requiredError = errors.querySelector('.required');
  const reg = new RegExp('^[a-zA-Z]+$');

  function checkValue(type) {

    const value = input.value;

    if (reg.test(value) == false) {
      requiredError.setAttribute('show-error', false);
    } else {

      if (type == 'blur') {
        requiredError.setAttribute('show-error', true);
      }

    }

  }

  input.addEventListener('blur', () => checkValue('blur'));
  input.addEventListener('focus', () => checkValue('focus'));

}

// Check for Length

function required(input, parent) {

  const isRequired = parent.getAttribute('data-required');
  const errors = parent.querySelector('.errors');
  const requiredError = errors.querySelector('.required');

  function checkValue(type) {

    const length = input.value.length;

    if (isRequired != null) {

      if (length > 0) {
        requiredError.setAttribute('show-error', false);
      } else {

        if (type == 'blur') {
          requiredError.setAttribute('show-error', true);
        }

      }

    }

  }

  input.addEventListener('blur', () => checkValue('blur'));
  input.addEventListener('focus', () => checkValue('focus'));

}

const obj = {
  checkForNumber,
  checkForZeroValue,
  checkForLetter,
  required,
}

export default obj;
