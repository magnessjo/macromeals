
// Import

import slider from './slider.js';
import registerSubmit from './registerSubmit.js';

// Variables

const section = document.querySelector('#login-options');
const buttons = Array.from(section.querySelectorAll('.register-cta'));
const infoSection = document.querySelector('#customer-info');

// Export

export default function() {

  buttons.forEach((button) => {

    button.addEventListener('click', () => {

      section.style.display = 'none';
      infoSection.style.display = 'block';
      slider(0);
      registerSubmit();

    });

  });

}
