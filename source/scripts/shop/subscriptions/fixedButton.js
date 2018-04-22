
// Variables

const checkoutButton = document.querySelector('.ready-to-checkout');
const wrapper = document.querySelector('.fixed-checkout-wrapper');
let buttonHeight = checkoutButton.offsetHeight;

function resize() {
  buttonHeight = checkoutButton.offsetHeight;
  wrapper.style.height = `${buttonHeight}px`;
}

// Scroll

function scroll() {

  const windowPosition = window.pageYOffset || document.documentElement.scrollTop;
  const windowHeight = window.innerHeight;
  const wrapperBounds = wrapper.getBoundingClientRect();

  if ( (wrapperBounds.top + buttonHeight) - windowHeight > 0) {
    checkoutButton.setAttribute('ready-to-checkout-fixed', true);
  } else {
    checkoutButton.setAttribute('ready-to-checkout-fixed', false);
  }

}

// Export

export default function() {

  window.addEventListener('scroll', e => { scroll() });
  window.addEventListener('resize', e => { resize() });

  resize();
  scroll();

}
