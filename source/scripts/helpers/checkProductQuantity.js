
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Check Product Quantity

export default function(element, errorText) {

  const id = element.getAttribute('data-id');
  const value = element.value;

  return new Promise((resolve, reject) => {

    fetchData(`id=${id}`, '/actions/MacroCommerce/Cart/getQuantity').then((response) => {

      const val = parseInt(value);

      if ( val > response && !Number.isNaN(val) ) {
        const span = errorText.querySelector('span');
        span.innerHTML = response;
        errorText.style.display = 'block';
        element.value = response;
      } else {
        errorText.style.display = 'none';
      }

      resolve();

    });

  });

}
