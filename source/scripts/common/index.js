
// Imports

import "babel-polyfill";
// import menu from './menu.js';
import cartButton from './cart-button.js';
import loginButton from './login-button.js';
import header from './header.js';
import loginUser from './loginUserForm.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  header();
  // menu();
  cartButton();
  loginButton();
  loginUser();

});
