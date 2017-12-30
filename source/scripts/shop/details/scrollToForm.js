
// Import

import scrollToLocation from 'scripts/helpers/scrollToLocation.js';

// Variables

const button = document.querySelector('button[data-action="scroll-to-form"]');
const form = document.querySelector('#product-addition');

// Export

export default function() {

  button.addEventListener('click', e => {
    e.preventDefault();
    scrollToLocation(form, 100);
  });

}
