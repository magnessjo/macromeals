
// Variables

const form = document.querySelector('form#product-addition');
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const summaryElement = form.querySelector('.summary');
const items = summaryElement.querySelector('.items');
let currentList = [];

// Update Dom Message

function updateDomMessage() {

  if (currentList.length > 0) {
    summaryElement.setAttribute('has-items', true);
  } else {
    summaryElement.setAttribute('has-items', false);
  }

}

// Append Items for display

function appendItemsForDisplay() {

  items.innerHTML = '';

  currentList.forEach( (item, i) => {

    const tag = document.createElement('p');
    const title = item.getAttribute('data-title');
    const size = item.getAttribute('data-size');
    const quantity = item.value;

    tag.innerHTML = `
      <span class="quanitiy">${quantity}</span>
      <span class="title">${title} <span class="size">(${size})</span></span>
    `;

    items.appendChild(tag);

    ga('ec:addProduct', {
      'name': title,
      'variant': size,
      'quantity': quantity
    });

  });

}

function process(input) {

  const index = currentList.indexOf(input);

  if (index >= 0) {
    currentList.splice(index, 1);
    if (input.value > 0) {
      currentList.push(input);
    }
  } else {
    if (input.value > 0) {
      currentList.push(input);
    }
  }

  updateDomMessage();
  appendItemsForDisplay(currentList);

}

export default function() {

  inputs.forEach( (input) => {

    input.addEventListener('keyup', (e) => {
      process(input);
    });

  });

}
