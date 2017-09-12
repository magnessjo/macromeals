
// Variables

const result = document.querySelector('.shipping-cost-result');
const form = document.querySelector('.shipping-calculator');
const textContainer = result.querySelector('.nimbus-large-bold');
const input = form.querySelector('input[type="text"]');
const submit = form.querySelector('input[type="submit"]');
const regex = /^(\d{5})?$/;

// Set Rate

function setRate(zip) {

  const xhr = new XMLHttpRequest();
  const url = '/actions/shippingRates';
  let data = `zip=${zip}&`;

  data += `${window.csrfTokenName}=${window.csrfTokenValue}`;

  xhr.open('POST', url);

  xhr.onreadystatechange = () => {

    if (xhr.readyState === xhr.DONE) {

      if (xhr.status === 200) {

        const text = JSON.parse(xhr.responseText);

        if (text == 'failure') {
          result.innerHTML = `There was an error getting your estimate.  Please contact us directly at <a href="info@macromeals.life">info@macromeals.life</a> for an estimate.`;
        } else {
          textContainer.innerHTML = `<span>Your Estimate</span>$${text}`;
          input.value = '';
          submit.setAttribute('disabled', true);
        }

        result.style.display = 'flex';

      }

    }

  }

  xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
  xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  xhr.send(data);

}

// Check Value

function checkValue() {

  const value = input.value;

  if (regex.test(value) && value.length == 5) {
    submit.removeAttribute('disabled');
  }  else {
    submit.setAttribute('disabled', true);
  }

}

// Export

export default function() {

  input.addEventListener('keyup', checkValue);
  input.addEventListener('keydown', checkValue);

  submit.addEventListener('click', (e) => {

    e.preventDefault();

    const value = input.value;
    console.log(value);
    setRate(value);

  });

}
