
// Import

import scrollTo from 'scripts/helpers/scrollToLocation.js';

// Variables

const documentBody = document.documentElement.scrollTop || document.body.scrollTop;
const wrapper = document.querySelector('.page-scroll-wrapper');
let nav;
let positionTop;

// Window Scroll

function windowSroll() {

  if (window.innerWidth > 768) {

    if (positionTop.top + documentBody < window.pageYOffset ) {
      nav.style.position = 'fixed';
    } else {
      nav.style.position = 'relative';
    }

  }

}

// Export Function

export default function() {

  if (wrapper) {

    // Init

    const buttons = Array.from(wrapper.querySelectorAll('button'));
    nav = wrapper.querySelector('.page-nav');
    positionTop = wrapper.getBoundingClientRect();

    // Click Event

    buttons.forEach((button) => {

      button.addEventListener('click', e => {

        const positionAttr = button.getAttribute('data-id');
        const element = document.querySelector(`section[id="${positionAttr}"]`);
        scrollTo(element);

      });

    });

    // Scroll Event

    window.addEventListener('scroll', windowSroll);

    // Load

    windowSroll();

  }

}
