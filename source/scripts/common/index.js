
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

  (function(h,o,t,j,a,r){
    h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
    h._hjSettings={hjid:837946,hjsv:6};
    a=o.getElementsByTagName('head')[0];
    r=o.createElement('script');r.async=1;
    r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
    a.appendChild(r);
  })(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');

});
