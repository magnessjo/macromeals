
// import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Export

export default function postToCart(data) {

  return new Promise( (resolve, reject) => {

    fetchData(data, '/actions/commerce/cart/removeLineItem').then( (response) => {
      resolve(response);
    });

  });

}
