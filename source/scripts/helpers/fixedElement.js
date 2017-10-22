


// Variables

let container;
let wrapper;
let containerPosition;
let containerWidth;

// Function

function scroll() {

  if (window.pageYOffset >= Math.abs(containerPosition)) {
    wrapper.style.position = 'fixed';
    wrapper.style.width = `${containerWidth}px`;
    container.style.height = `${wrapper.offsetHeight}px`;
  } else {
    wrapper.style.position = 'relative';
    container.style.height = 'inherit';
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

export default function(parent, child, includeResize = false) {

  let containerBox = parent.getBoundingClientRect();

  container = parent;
  wrapper = child;
  containerPosition = containerBox.top + window.scrollY;
  containerWidth = container.offsetWidth;

  window.addEventListener('scroll', scroll);

  if (includeResize) {
    window.addEventListener('resize', resize);
  }

}
