
// Imports

import pageScroll from './pageScroll';

// Variables

const logos = Array.from(document.querySelectorAll('.image-grid .logo'));

// Load

document.addEventListener('DOMContentLoaded', () => {

  pageScroll(logos);

});
