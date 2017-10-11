
// Import

import slider from './slider.js';

// Variables

const form = document.querySelector('form#user-info');

// Export

export default function() {

  form.addEventListener('submit', (e) => {

    e.preventDefault();
    slider(1, true);

  });

}
