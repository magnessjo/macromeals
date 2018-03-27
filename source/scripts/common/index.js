
// Imports

import "babel-polyfill";
import menu from './menu.js';
import cartButton from './cart-button.js';
import loginButton from './login-button.js';
import header from './header.js';
import loginUser from './loginUserForm.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  // if ('serviceWorker' in navigator) {
  //   navigator.serviceWorker.register('/serviceWorker.js').then( (reg) => {
  //     console.log('Registration succeeded. Scope is ' + reg.scope);
  //   }).catch( (error) => {
  //     console.log('Registration failed with ' + error);
  //   });
  // }

  // navigator.serviceWorker.getRegistrations().then(function(registrations) {
  //  for(let registration of registrations) {
  //   registration.unregister()
  // } })

  header();
  menu();
  cartButton();
  loginButton();
  loginUser();

  ga('require', 'ec');

});
