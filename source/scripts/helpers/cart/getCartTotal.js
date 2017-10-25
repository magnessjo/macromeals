
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Export

export default function() {

  return new Promise((resolve, reject) => {

    fetchData(``, '/actions/MacroCommerce/Cart/getCartTotals').then( (response) => {
      resolve(response);
    });

  });

}
