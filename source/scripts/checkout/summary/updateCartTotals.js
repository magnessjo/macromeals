
// Import

import formatStringForDollar from 'scripts/helpers/formatStringForDollar.js';

// Export

export default function(cart) {

  console.log(cart);

  const cartTotal = document.querySelector('.cart-total');

  if (cartTotal) {

    const totalElement = cartTotal.querySelector('[data-type="total-amount"]');
    const subTotalElement = cartTotal.querySelector('[data-type="items-amount"]');
    const taxAmount = cartTotal.querySelector('[data-type="tax-amount"]');

    const totalNumber = formatStringForDollar(cart.totalPrice);
    const subTotalNumber = formatStringForDollar(cart.itemSubtotal);
    const taxNumber = formatStringForDollar(cart.totalTax);

    totalElement.innerHTML = totalNumber;
    subTotalElement.innerHTML = subTotalNumber;
    taxAmount.innerHTML = taxNumber;

  }


}
