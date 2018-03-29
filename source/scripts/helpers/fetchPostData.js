
// import

import 'whatwg-fetch';

// Export Post Fetch

export default function fetchData(data, url) {

  return new Promise((resolve, reject) => {

    fetch(url, {
      method: "POST",
      body: data,
      headers: {
        "Content-Type": 'application/x-www-form-urlencoded',
        'X-Requested-With': 'XMLHttpRequest',
        'Accept': 'application/json'
      },
      credentials: "same-origin"
    }).then( (response) => {
      console.log(response);
      resolve(response.json());
    }, (error) => {
      console.log(`error : ${error.message }`);
      reject(error);
    });

  });

}
