
// Import

import formatStringForDollar from 'scripts/helpers/formatStringForDollar.js';

// Export

export default function(cart) {

  const cartTotal = document.querySelector('#cart-total');

  if (cartTotal) {

    const totalElement = cartTotal.querySelector('[data-type="total-amount"]');
    const subTotalElement = cartTotal.querySelector('[data-type="items-amount"]');
    const taxElement = cartTotal.querySelector('[data-type="tax-amount"]');
    const shippingElement = cartTotal.querySelector('[data-type="shipping-amount"]');

    const totalNumber = formatStringForDollar(cart.totalPrice);
    const subTotalNumber = formatStringForDollar(cart.itemSubtotal);
    const taxNumber = formatStringForDollar(cart.totalTax);
    const shippingNumber = formatStringForDollar(cart.baseShippingCost);

    totalElement.innerHTML = totalNumber;
    subTotalElement.innerHTML = subTotalNumber;
    taxElement.innerHTML = taxNumber;
    shippingElement.innerHTML = shippingNumber;

  }


}
