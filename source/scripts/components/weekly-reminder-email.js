
// Imports

import fetchData from 'scripts/helpers/fetchPostData.js';

// Variables

const container = document.querySelector('.weekly-reminder');

// Export

export default function(form) {

  return new Promise( ( resolve, reject) => {

    if (container) {

      const checkbox = container.querySelector('input[type="checkbox"]');

      if (checkbox.checked) {

        const email = form.querySelector('input[name="emailAddress"]');
        const firstName = form.querySelector('input[name="shippingAddress[firstName]"]');
        const lastName = form.querySelector('input[name="shippingAddress[lastName]"]');

        let data = `${window.csrfTokenName}=${window.csrfTokenValue}&email=${email.value}&firstName=${firstName.value}&lastName=${lastName.value}`;

        fetchData(data, '/reminder').then( (response) => {
          resolve();
        });

      } else {
        resolve();
      }

    } else {
      resolve();
    }

  });

}
