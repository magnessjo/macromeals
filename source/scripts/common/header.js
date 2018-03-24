
// Variables

const header = document.querySelector('header');
const mobileMenu = header.querySelector('#menu');

// Add Overlay from Selection

function addOverlay() {

  const nav = header.querySelector('nav');
  const buttons = Array.from(nav.querySelectorAll('button'));

  buttons.forEach((button) => {

    button.addEventListener('click', () => {

      const parent = button.parentNode;
      const overlay = parent.querySelector('.options');
      const isHidden = overlay.getAttribute('aria-hidden');

      if (isHidden == 'true') {
        overlay.setAttribute('aria-hidden', 'false');
        parent.setAttribute('showing', 'true');
        overlay.style.visibility = 'visible';
      } else {
        overlay.setAttribute('aria-hidden', 'true');
        parent.setAttribute('showing', 'false');
        setTimeout(() => { overlay.style.visibility = 'hidden' }, 1000);
      }

    });

  });

}

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

  addOverlay();
  mobileExpand();

}
