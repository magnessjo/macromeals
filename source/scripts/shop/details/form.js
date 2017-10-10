
// import

import 'whatwg-fetch';

// Variables

const section = document.querySelector('#details');
const form = section.querySelector('form');
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const submit = form.querySelector('input[type="submit"]');
const totalPrice = form.querySelector('[data-total="price"]');
let showSubmit = false;

// Total

function caculateTotal(total) {

  totalPrice.innerHTML = `$${total}`;

}

// check values

function checkInputValues() {

  const reg = new RegExp('^[0-9]+$');
  let isError = false;
  let total = 0;

  inputs.forEach((input) => {

    if (isError) {
      showSubmit = false;
    }

    // Check for no entry

    if(input.value.length == 0) {
      isError = true;
      return;
    } else {
      isError = false;
    }

    // Check for any digit other than a number

    if(reg.test(input.value) == false) {
      isError = true;
      return;
    } else {
      isError = false;
    }

    // Check for a zero value

    if (input.value == 0) {
      isError = true;
    } else {
      isError = false;
    }

    if (!isError) {
      const wrapper = input.parentNode;
      const parent = wrapper.parentNode;
      const hiddenQuanity = parent.querySelector('input[name="qty"]');
      const priceString = parent.querySelector('.price').innerHTML;
      const price = priceString.slice(1, priceString.length);
      const itemTotal = input.value * price;

      total = total + itemTotal;
      hiddenQuanity.value = input.value;

      showSubmit = true;
      caculateTotal(total);

    }

  });

}

//

function updateUI(e) {

  checkInputValues();

  if (showSubmit) {
    submit.style.display = 'block';
  } else {
    submit.style.display = 'none';
  }

}

// Fetch

function fetchData(data, url) {

  return new Promise((resolve, reject) => {

    fetch(url, {
      method: "POST",
      body: data,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        'X-Requested-With': 'XMLHttpRequest'
      },
      credentials: "same-origin"
    }).then(function(response) {
      resolve(response.json());
    }, function(error) {
      console.log(`error : ${error.message }`);
    });

  });

}

// Check quantity

function checkQuantity(element, errors) {

  const stock = errors.querySelector('.stock');
  const id = element.getAttribute('data-id');
  const value = element.value;

  return new Promise((resolve, reject) => {

    fetchData(`id=${id}`, '/actions/MacroCommerce/Cart/getQuantity').then((response) => {
      if (value > response) {
        const span = errors.querySelector('span');
        span.innerHTML = response;
        stock.style.display = 'block';
        element.value = response;
      } else {
        stock.style.display = 'none';
      }
      resolve();
    });

  });

}

// Submit

function submitForm(e) {

  let submittedCorrectly = true;

  e.preventDefault();

  inputs.forEach((input, i) => {

    let data = '';

    data += `${window.csrfTokenName}=${window.csrfTokenValue}&`;

    if (input.value != 0) {

      const id = input.getAttribute('data-id');

      data += `purchasableId=${id}&`;
      data += `qty=${input.value}`;
      fetchData(data, '/actions/commerce/cart/updateCart').then((response) => {

        if (response.success) {
          input.value = 0;
        } else {
          submittedCorrectly = false;
        }

      });

    }

    if (i == inputs.length - 1) {

      if (submittedCorrectly) {
        form.style.display = 'none';
      }

    }

  });

}

// Export

export default function() {

  inputs.forEach((input) => {

    const parent = input.parentNode;
    const wrapper = parent.parentNode;
    const container = wrapper.parentNode;
    const errors = container.querySelector('.errors');

    input.addEventListener('keyup', (e) => updateUI(e, input) );

    input.addEventListener('change', (e) => {
      checkQuantity(input, errors).then(() => {
        updateUI(e, input);
      });
    });

    input.addEventListener('blur', (e) => {

      if (input.value == '') {
        input.value = 0;
      } else {
        updateUI(e, input)
      }

    });

  });

  form.addEventListener('submit', (e) => { submitForm(e) });

}
