
// import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Export

export default function postToCart(data) {

  return new Promise((resolve, reject) => {

    fetchData(data, '/actions/commerce/cart/update-cart').then( (response) => {

      console.log(response);
      resolve(response);
    });

  });

}
