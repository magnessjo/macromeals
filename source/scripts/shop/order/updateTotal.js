
// Import

import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

export default function(element) {

  const parent = findParentNode(element, 'input-container');
  const inputs = Array.from(parent.querySelectorAll('input[type="number"]'));
  const additionText = parent.querySelector('.addition-text');
  const title = inputs[0].getAttribute('data-title');
  let showAdditionMessage = false;
  let message = '';
  let totalQuantity = 0;
  let andText = false;

  inputs.forEach( (input, i) => {

    if (input.value > 0) {

      const size = input.getAttribute('data-size');
      const quantity = input.value;
      totalQuantity += quantity;

      if (andText) message += ' and ';

      showAdditionMessage = true;
      message += `${quantity} ${size}`;
      andText = true;

    }

  });

  if (showAdditionMessage) {
    additionText.style.display = 'block';
    const mealText = totalQuantity > 1 ? 'meals' : 'meal'
    additionText.innerHTML = `<span>${message}</span> ${title} ${mealText} has been added to your cart`;
  } else {
    additionText.style.display = 'none';
  }

  // ga('ec:addProduct', {
  //   'name': title,
  //   'variant': size,
  //   'quantity': quantity
  // });

}
