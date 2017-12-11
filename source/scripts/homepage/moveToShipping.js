
// import

import scrollTo from 'scripts/helpers/scrollToLocation.js';

// Variables

const button = document.querySelector('button.shipping-information');
const shippingSection = document.querySelector('#shipping-info');

// Export

export default function() {

  button.addEventListener('click', () => {

    scrollTo(shippingSection);

  });

}
