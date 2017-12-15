
// Imports

import postManPlus from './postManPlus.js';
// import harfordPackShip from './harfordPackShip.js';
import selectOption from './selectOption.js';
import expandPickups from './expandPickups.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  expandPickups();
  selectOption();

  var script = document.createElement('script');
  script.src = 'https://maps.google.com/maps/api/js?sensor=false&key=AIzaSyClI-Rxeg_1MsW2Ceq-1egM34AMHpNsVPQ&callback=mapInit';
  document.body.appendChild(script);

  window.mapInit = function () {
    postManPlus();
    // harfordPackShip();
  }

});
