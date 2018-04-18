
// Import

import fetchPostData from 'scripts/helpers/fetchPostData.js';

// Variables

const form = document.querySelector('#example');

// Export

document.addEventListener('DOMContentLoaded', e => {

  form.addEventListener('submit', e => {
    e.preventDefault();
    let data = `${window.csrfTokenName}=${window.csrfTokenValue}`;
    fetchPostData(data, '/subscriptionType').then( (response) => {
      console.log(response)
    });
  });

});
