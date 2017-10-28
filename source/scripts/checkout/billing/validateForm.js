
// Variables

const form = document.querySelector('form');
const errors = form.querySelector('.errors');

function expirationInput() {

  const container = form.querySelector('.expiration');
  const input = container.querySelector('input');
  const overlay = container.querySelector('.overlay');
  const hiddenMonth = form.querySelector('[data-stripe="exp_month"]');
  const hiddenYear = form.querySelector('[data-stripe="exp_year"]');
  const expiredError = errors.querySelector('.expired');
  let overlayShowing = false;

  function showError() {
    container.setAttribute('valid', false);
    container.setAttribute('has-error', true);
    expiredError.setAttribute('show-error', true);
  }

  function hideError(month, year) {
    container.setAttribute('valid', true);
    container.setAttribute('has-error', false);
    expiredError.setAttribute('show-error', false);
    hiddenMonth.value = month;
    hiddenYear.value = year;
  }

  input.addEventListener('keypress', (e) => {

    if (input.value.length == 2 && e.keyCode == 47) return;

    if (input.value.length == 2) {
      input.value = input.value + '/';
    }

  });

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

  input.addEventListener('blur', () => {

    const isLength = input.value.length == 5;

    if (!isLength) {
      showError();
      return;
    }

    const stringArray = input.value.split('/');
    const month = parseInt(stringArray[0]);
    const year = parseInt(stringArray[1]);
    const today = new Date();
    const expirationDate = new Date(`20${year}`, month, 1);

    today > expirationDate ? showError() : hideError(month, year)

  });

}

// Export

export default function() {

  expirationInput();

}
