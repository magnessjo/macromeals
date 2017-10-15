
// Variables

const header = document.querySelector('header');
const nav = header.querySelector('nav');
const buttons = Array.from(nav.querySelectorAll('button'));

// Export

export default function() {

  buttons.forEach((button) => {

    button.addEventListener('click', () => {

      const parent = button.parentNode;
      const overlay = parent.querySelector('.options');
      const isHidden = overlay.getAttribute('aria-hidden');

      if (isHidden == 'true') {
        overlay.setAttribute('aria-hidden', 'false');
        parent.setAttribute('showing', 'true');
      } else {
        overlay.setAttribute('aria-hidden', 'true');
        parent.setAttribute('showing', 'false');
      }

    });

  });

}
