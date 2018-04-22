
// Import

import fetchPostData from 'scripts/helpers/fetchPostData.js';
import increment from './increment.js';
import inputEvents from './inputEvents.js';
import fixedButton from './fixedButton.js';
import checkButtonAddition from './checkButtonAddition.js';

// Export

document.addEventListener('DOMContentLoaded', e => {

  increment();
  inputEvents();
  fixedButton();
  checkButtonAddition();


  // Form submission for Subscriptions API Call

  // form.addEventListener('submit', e => {
  //   e.preventDefault();
  //   let data = `${window.csrfTokenName}=${window.csrfTokenValue}`;
  //   fetchPostData(data, '/subscriptionType').then( (response) => {
  //     console.log(response);
  //   });
  // });

});
