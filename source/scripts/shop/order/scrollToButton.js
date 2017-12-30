
// Variables

const readyToCheckoutButton = document.querySelector('.ready-to-add');
const form = document.querySelector('form#product-addition');
const buttonWidth = readyToCheckoutButton.offsetWidth;
let formPosition = 0;

function resize() {
  const bounds = form.getBoundingClientRect();
  formPosition = bounds.top;
}

// Scroll

function scroll() {

  const windowPosition = window.pageYOffset || document.documentElement.scrollTop;

  if (windowPosition > formPosition) {
    readyToCheckoutButton.style.transform = `translateX(0)`;
    readyToCheckoutButton.style.transition = `transform .5s`;
  } else {
    readyToCheckoutButton.style.transform = `translateX(-${buttonWidth}px)`;
    readyToCheckoutButton.style.transition = `transform 1s`;
  }

}

// Export

export default function() {

  window.addEventListener('scroll', e => { scroll() });
  window.addEventListener('resize', e => { resize() });

  resize();

}
