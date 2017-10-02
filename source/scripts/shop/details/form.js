
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
      const priceString = parent.querySelector('.price').innerHTML;
      const price = priceString.slice(1, priceString.length);
      const itemTotal = input.value * price;
      total = total + itemTotal;
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

// Export

export default function() {

  inputs.forEach((input) => {

    input.addEventListener('change', (e) => updateUI(e) );
    input.addEventListener('keyup', (e) => updateUI(e) );

    input.addEventListener('blur', (e) => {

      if (input.value == '') {
        input.value = 0;
      } else {
        updateUI(e)
      }

    });

  });

}
