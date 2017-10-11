
// Import

import slider from './slider.js';

// Variables

const section = document.querySelector('#login-options');
const button = section.querySelector('.guest-cta');
const registerSection = document.querySelector('#customer-info');
const progressBar = document.querySelector('#address-info .progress-bar');

// Export

export default function() {

  button.addEventListener('click', () => {

    section.style.display = 'none';
    registerSection.style.display = 'block';
    progressBar.style.display = 'none';
    slider(1);

  });

}
