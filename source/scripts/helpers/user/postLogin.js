
// import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Export

export default function(data) {

  return new Promise((resolve, reject) => {

    fetchData(data, '/actions/users/login').then((response) => {
      resolve(response);
    });

  });

}
