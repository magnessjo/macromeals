
// Import

import formatStringForDollar from 'scripts/helpers/formatStringForDollar.js';

// Variables

const cartTotal = document.querySelector('.cart-total');
const totalElement = cartTotal.querySelector('[data-type="total-amount"]');
const subTotalElement = cartTotal.querySelector('[data-type="items-amount"]');
const taxAmount = cartTotal.querySelector('[data-type="tax-amount"]');

// Export

export default function(cart) {

  const totalNumber = formatStringForDollar(cart.totalPrice);
  const subTotalNumber = formatStringForDollar(cart.itemSubtotal);
  const taxNumber = formatStringForDollar(cart.totalTax);

  totalElement.innerHTML = totalNumber;
  subTotalElement.innerHTML = subTotalNumber;
  taxAmount.innerHTML = taxNumber;

}
