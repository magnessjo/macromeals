
// import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Export

export default function postToCart(data) {

  return new Promise((resolve, reject) => {

    fetchData(data, '/update-cart').then((response) => {
      resolve(response);
    });

  });

}
