
// Import

import getCartItems from 'scripts/helpers/cart/getCartItems.js';

// Variables

const header = document.querySelector('header');
const button = header.querySelector('.cart');
const buttonNumber = button.querySelector('.number');

// Export Function

export default function() {

  getCartItems().then( (response) => {

    if (response.success) {

      let total = 0;

      response.items.forEach( (item) => {
        total += parseInt(item.quantity);
      });

      buttonNumber.innerHTML = total;

    }



  });

}
