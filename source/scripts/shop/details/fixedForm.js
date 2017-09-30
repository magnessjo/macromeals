
// Variables

const container = document.querySelector('.product-actions');
const containerBox = container.getBoundingClientRect();
const form = container.querySelector('form');
const formHeight = form.offsetHeight;
let windowPosition = window.pageYOffset;
let containerPosition = containerBox.top + window.scrollY;
let containerWidth = container.offsetWidth;

// Function

function scroll() {

  windowPosition = window.pageYOffset;

  if (windowPosition >= Math.abs(containerPosition)) {
    form.style.position = 'fixed';
    form.style.width = `${containerWidth}px`;
  } else {
    form.style.position = 'relative';
  }

}

// function resize

function resize() {

  containerWidth = container.offsetWidth;

  if (window.innerWidth > 767) {
    form.style.width = `${containerWidth}px`;
  } else {
    form.style.width = 'inherit';
  }

}

// Export Function

export default function() {

  window.addEventListener('scroll', scroll);
  window.addEventListener('resize', resize);

}
