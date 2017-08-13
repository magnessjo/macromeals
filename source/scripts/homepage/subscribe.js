
// Variables

const form = document.querySelector('form');
const button = form.querySelector('input[type="submit"]');
const firstName = form.querySelector('#firstName');
const lastName = form.querySelector('#lastName');
const email = form.querySelector('#email');
const requiredFields = Array.from(form.querySelectorAll('.required-feild'));

// Check Submit Action

function checkSubmit() {

  button.addEventListener('click', e => {

    let isValid = true;

    e.preventDefault();

    if (firstName.value == '') {
      isValid = false;
    }

    if (lastName.value == '') {
      isValid = false;
    }

    if (email.value == '') {
      isValid = false;
    }

    if (isValid) {
      form.submit();
    }

  });

}

// Check blur

function checkBlur() {

  requiredFields.forEach((wrapper) => {

    const input = wrapper.querySelector('input');
    input.addEventListener('blur', e => {

      if (input.value == '') {
        wrapper.classList.add('not-valid');
        wrapper.classList.remove('valid');
      } else {
        wrapper.classList.add('valid');
        wrapper.classList.remove('not-valid');
      }

    });

  });

  requiredFields.forEach((wrapper) => {

    const input = wrapper.querySelector('input');
    input.addEventListener('focus', e => {

      wrapper.classList.remove('valid');
      wrapper.classList.remove('not-valid');

    });

  });

}

// Export

export default function() {

  checkBlur();
  checkSubmit();

}
