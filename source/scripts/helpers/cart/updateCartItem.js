
// import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Export

export default function(data) {

  return new Promise((resolve, reject) => {

    fetchData(data, '/actions/commerce/cart/update-line-item').then( (response) => {
      resolve(response);
    });

  });

}
