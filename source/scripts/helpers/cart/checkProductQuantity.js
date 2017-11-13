
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Check Product Quantity

export default function(element, errorText) {

  const id = element.getAttribute('data-id');
  const value = element.value;

  return new Promise((resolve, reject) => {

    fetchData(`${window.csrfTokenName}=${window.csrfTokenValue}&id=${id}`, '/actions/MacroCommerce/Cart/getQuantity').then((response) => {

      const val = parseInt(value);

      if ( val > response && !Number.isNaN(val) ) {
        const span = errorText.querySelector('span');
        const event = new Event('keyup');
        span.innerHTML = response;
        errorText.style.display = 'block';
        element.value = response;
        element.dispatchEvent(event);
      } else {
        errorText.style.display = 'none';
      }

      resolve();

    });

  });

}
