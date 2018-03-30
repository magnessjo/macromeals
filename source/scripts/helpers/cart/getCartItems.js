
// Variables

const url = '/cartItems';

// Export

export default function() {

  return new Promise((resolve, reject) => {

    fetch(url, {
      method: "GET",
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      credentials: "same-origin"
    }).then(function(response) {
      resolve(response.json());
    }, function(error) {
      console.log(`error : ${error.message }`);
    });

  });

}
