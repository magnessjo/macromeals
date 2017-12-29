
// Variables

const form = document.querySelector('#product-addition');
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const submit = form.querySelector('input[type="submit"]');
const totalElement = form.querySelector('[data-total="price"]');

function total() {

  let total = 0;

  inputs.forEach( (input) => {

    const id = input.getAttribute('data-id');
    const cost = input.getAttribute('data-cost');
    total += parseInt(input.value) * parseFloat(cost);

  });

  totalElement.innerHTML = `$${total.toFixed(2)}`;

}

function button() {

  let disableButton = true;

  inputs.forEach( (input) => {
    if (parseInt(input.value) > 0) disableButton = false;
  });

  submit.disabled = disableButton;

}

const obj = {
  total,
  button
}

export default obj;
