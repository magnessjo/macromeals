
// Variables

const container = document.querySelector('.product-actions');
const containerBox = container.getBoundingClientRect();
const form = container.querySelector('form');
const formHeight = form.offsetHeight;
let windowPosition = window.pageYOffset;
let containerPosition = containerBox.top + window.scrollY;

// Function

function scroll() {

  windowPosition = window.pageYOffset;

  if (windowPosition >= Math.abs(containerPosition)) {
    form.style.position = 'fixed';
  } else {
    form.style.position = 'relative';
  }

}


// Export Function

export default function() {

  window.addEventListener('scroll', scroll);

}
