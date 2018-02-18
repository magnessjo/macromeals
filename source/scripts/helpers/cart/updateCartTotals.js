
// Import

import formatStringForDollar from 'scripts/helpers/formatStringForDollar.js';

// Export

export default function(cart) {

  const cartTotal = document.querySelector('#cart-total');
  const adjustments = cart.adjustments;
  const discounts = typeof adjustments !== 'undefined' ? adjustments.Discount : 'undefined';
  let discountCalcNumber = 0;

  if (typeof discounts !== 'undefined' && discounts.length > 0) {

    discounts.forEach( (discount) => {
      discountCalcNumber += discount.amount;
    });

  }

  if (cartTotal) {

    const totalElement = cartTotal.querySelector('[data-type="total-amount"]');
    const subTotalElement = cartTotal.querySelector('[data-type="items-amount"]');
    const taxElement = cartTotal.querySelector('[data-type="tax-amount"]');
    const shippingElement = cartTotal.querySelector('[data-type="shipping-amount"]');
    const discountElement = cartTotal.querySelector('[data-type="discount-amount"]');

    if (totalElement) {
      const totalNumber = formatStringForDollar(cart.totalPrice);
      totalElement.innerHTML = `$${totalNumber}`;
    }

    if (subTotalElement) {
      const subTotalNumber = formatStringForDollar(cart.itemSubtotal);
      subTotalElement.innerHTML = subTotalNumber;
    }

    if (taxElement) {
      const taxNumber = formatStringForDollar(cart.totalTax);
      taxElement.innerHTML = taxNumber;
    }

    if (shippingElement) {
      const shippingNumber = formatStringForDollar(cart.baseShippingCost);
      shippingElement.innerHTML = shippingNumber;
    }

    if (discountElement) {

      const discountNumber = formatStringForDollar(discountCalcNumber);
      discountElement.innerHTML = `(${discountNumber})`;

      discountCalcNumber > 0 ? discountElement.setAttribute('data-show', true) : discountElement.setAttribute('data-show', false);

    }

  }

}
