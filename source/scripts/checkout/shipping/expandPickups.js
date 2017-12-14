
// Variables

const container = document.querySelector('.pickup-list');
const wrapper = container.querySelector('.wrapper');
const button = document.querySelector('.show-pickups');

// Size Element

function sizeElement(transition = true) {

  const wrapperSize = wrapper.offsetHeight;
  container.style.height = `${wrapperSize}px`;
  container.style.transition = transition ? 'height 1s' : 'none';

}

function collapleElement() {

  container.style.height = `0`;
  container.style.transition = 'height 1s';

}

// Export

export default function() {

  button.addEventListener('click', () => {

    const isShowing = button.getAttribute('showing');

    if (isShowing) {
      collapleElement();
      button.removeAttribute('showing');
    } else {
      sizeElement();
      button.setAttribute('showing', true);
    }

  });

  window.addEventListener('resize', () => { sizeElement(false) });

}
