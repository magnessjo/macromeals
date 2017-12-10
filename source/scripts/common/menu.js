
// Variables

const header = document.querySelector('header');
const button = header.querySelector('.menu-toggle');
const menu = document.querySelector('menu');
const wrapper = menu.querySelector('.mobile-nav');
const overlays = Array.from(header.querySelectorAll('.header-overlay'));

// Show

function show() {

  const height = wrapper.offsetHeight;
  menu.style.height = `${height}px`;

  overlays.forEach((elm) => {
    elm.setAttribute('aria-hidden', true);
  });

}

function close() {

  menu.style.height = `0`;

}

// Export

export default function() {

  button.addEventListener('click', () => {

    const isSet = button.getAttribute('data-showing');

    if (isSet == 'false') {

      button.setAttribute('data-showing', 'true');
      show();

    } else {

      button.setAttribute('data-showing', 'false');
      close();

    }

  });

}
