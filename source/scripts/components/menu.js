
// Variables

const openButton = document.querySelector('header .menu-toggle');
const menu = document.querySelector('menu');
const closeButton = menu.querySelector('button');
const showClass = 'show';

// Show

function show() {
  menu.classList.add(showClass);
}

function close() {
  menu.classList.remove(showClass);
}

// Export

export default function() {

  openButton.addEventListener('click', show);
  closeButton.addEventListener('click', close);

}
