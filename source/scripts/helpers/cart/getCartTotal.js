
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Check Product Quantity

export default function(element, errorText) {

  if (element) {
    const id = element.getAttribute('data-id');
    const value = element.value;
  }

  return new Promise((resolve, reject) => {

    fetchData(``, '/actions/MacroCommerce/Cart/getCartTotal').then( (response) => {

      resolve(response);

    });

  });

}
