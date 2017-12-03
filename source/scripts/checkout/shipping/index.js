
// Imports

import postManPlus from './postManPlus.js';
// import harfordPackShip from './harfordPackShip.js';
import selectOption from './selectOption.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  selectOption();

  var script = document.createElement('script');
  script.src = 'https://maps.google.com/maps/api/js?sensor=false&callback=mapInit';
  document.body.appendChild(script);

  window.mapInit = function () {
    postManPlus();
    // harfordPackShip();
  }

});
