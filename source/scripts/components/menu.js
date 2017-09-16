
// Variables

const button = document.querySelector('header .menu-toggle');
const menu = document.querySelector('menu');
const wrapper = menu.querySelector('.mobile-nav');
const text = button.querySelector('.text');

// Show

function show() {

  const height = wrapper.offsetHeight;
  menu.style.height = `${height}px`;
  text.innerHTML = 'Close';

}

function close() {

  menu.style.height = `0`;
  text.innerHTML = 'Menu';

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
