
// Variables

const header = document.querySelector('header');
const mobileMenu = header.querySelector('#menu');

// Mobile Expand

function mobileExpand() {

  const mobileNavContainer = header.querySelector('.mobile-nav');
  const dropdowns = Array.from(mobileNavContainer.querySelectorAll('.dropdown'));

  dropdowns.forEach( (item) => {

    item.addEventListener('click', () => {

      const isShowing = item.getAttribute('data-showing');
      const linksContainer = item.querySelector('.nav-expand');
      const linksWrapper = linksContainer.querySelector('div');
      const linkOffset = linksWrapper.offsetHeight - 20;

      if (isShowing == 'false') {

        linksContainer.style.height = `${linkOffset}px`;
        linksContainer.style.transition = 'height 1s';

        mobileMenu.style.height = `${mobileNavContainer.offsetHeight + linkOffset}px`;
        mobileMenu.style.height = 'height 1s';
        item.setAttribute('data-showing', true);

      } else {
        linksContainer.style.height = 0;
        linksContainer.style.transition = 'height 1s';

        mobileMenu.style.height = `${mobileNavContainer.offsetHeight - linkOffset}px`;
        mobileMenu.style.height = 'height .5s';
        item.setAttribute('data-showing', false);

      }

    });

  });

}

// Export

export default function() {

  // addOverlay();
  mobileExpand();

}
