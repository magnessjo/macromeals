
// Variables

const container = document.querySelector('.product-actions');
const containerBox = container.getBoundingClientRect();
const wrapper = container.querySelector('.fixed-wrapper');
const wrapperHeight = wrapper.offsetHeight;

let windowPosition = window.pageYOffset;
let containerPosition = containerBox.top + window.scrollY;
let containerWidth = container.offsetWidth;

// Function

function scroll() {

  windowPosition = window.pageYOffset;

  if (windowPosition >= Math.abs(containerPosition)) {
    wrapper.style.position = 'fixed';
    wrapper.style.width = `${containerWidth}px`;
  } else {
    wrapper.style.position = 'relative';
  }

}

// function resize

function resize() {

  containerWidth = container.offsetWidth;

  if (window.innerWidth > 767) {
    wrapper.style.width = `${containerWidth}px`;
  } else {
    wrapper.style.width = 'inherit';
  }

}

// Export Function

export default function() {

  window.addEventListener('scroll', scroll);
  window.addEventListener('resize', resize);

}
