
// Import

import formatStringForDollar from 'scripts/helpers/formatStringForDollar.js';

// Export

export default function(cart) {

  const cartTotal = document.querySelector('#cart-total');
  const adjustments = cart.adjustments;
  const discounts = typeof adjustments !== 'undefined' ? adjustments.Discount : 'undefined';

  if (cartTotal) {

    const totalElement = cartTotal.querySelector('[data-type="total-amount"]');
    const subTotalElement = cartTotal.querySelector('[data-type="items-amount"]');
    const taxElement = cartTotal.querySelector('[data-type="tax-amount"]');
    const shippingElement = cartTotal.querySelector('[data-type="shipping-amount"]');
    const discountElement = cartTotal.querySelector('[data-type="discount-amount"]');

    const totalNumber = formatStringForDollar(cart.totalPrice);
    const subTotalNumber = formatStringForDollar(cart.itemSubtotal);
    const taxNumber = formatStringForDollar(cart.totalTax);
    const shippingNumber = formatStringForDollar(cart.baseShippingCost);
    const discountNumber = typeof discounts !== 'undefined' ? formatStringForDollar(adjustments.Discount[0].amount) : '0.00'

    totalElement.innerHTML = `$${totalNumber}`;
    subTotalElement.innerHTML = subTotalNumber;
    taxElement.innerHTML = taxNumber;
    shippingElement.innerHTML = shippingNumber;
    discountElement.innerHTML = `(${discountNumber})`;

  }

}
