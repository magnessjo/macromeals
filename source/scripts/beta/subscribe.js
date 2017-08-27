
// Variables

const form = document.querySelector('form');
const inputs = Array.from(form.querySelectorAll('input[type="text"]'));
const state = form.querySelector('select');
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

      const xhr = new XMLHttpRequest();
      const url = '/actions/contactForm/client/sendMessage';
      const selected = state.options[state.selectedIndex].value;
      let data = '';

      console.log(selected);

      data = `${window.csrfTokenName}=${window.csrfTokenValue}&`;
      inputs.forEach((item) => {

        if(item.value != '') {
          const test = item.getAttribute('name');
          data += `${test}=${item.value}&`;
        }

      });

      data += `state=${selected}`;

      console.log(data);

      xhr.open('POST', url);

      xhr.onreadystatechange = () => {

        if (xhr.readyState === xhr.DONE) {
          if (xhr.status === 200) {
            const text = JSON.parse(xhr.responseText);
            if (text == 'success') {
              form.style.display = 'none';
            }
          }
        }

      }

      xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
      xhr.send(data);

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
