
// Variables

let container;
let wrapper;
let containerPosition;
let containerWidth;

// Function

function scroll() {

  if (window.pageYOffset >= Math.abs(containerPosition)) {
    wrapper.style.position = 'fixed';
    container.style.height = `${wrapper.offsetHeight}px`;

    if (window.innerWidth > 767) {
      wrapper.style.width = `${containerWidth}px`;
    } else {
      wrapper.style.width = `${window.innerWidth}px`;
    }

    wrapper.setAttribute('scrolling', true);
  } else {
    wrapper.style.position = 'relative';
    container.style.height = 'inherit';
    wrapper.setAttribute('scrolling', false);
  }

}

// function resize

function resize() {

  const containerBox = container.getBoundingClientRect();

  containerWidth = container.offsetWidth;
  containerPosition = containerBox.top + window.scrollY;

  if (window.innerWidth > 767) {
    wrapper.style.width = `${containerWidth}px`;
  } else {
    wrapper.style.width = `${window.innerWidth}px`;
  }

}

// Export Function

export default function(parent, child) {

  container = parent;
  wrapper = child;

  window.addEventListener('scroll', scroll);
  window.addEventListener('resize', resize);

  resize();

}
