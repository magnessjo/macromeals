
// Variables

const container = document.querySelector('.notice');
const text = container.querySelector('.text');
const button = container.querySelector('h1');
const wrapper = container.querySelector('.expand-content');
const padding = parseInt(window.getComputedStyle(text).getPropertyValue('padding-top'));

// Resize

function resize() {

  if (button.classList.contains('expanded')) {
    const height = wrapper.querySelector('div').offsetHeight + padding * 2;
    wrapper.style.height = `${height}px`;
    wrapper.style.transition = 'none';
  }

}

// Export

export default function() {

  button.addEventListener('click', () => {

    const height = wrapper.querySelector('div').offsetHeight + padding * 2;

    wrapper.style.transition = 'height 1s';

    if  (wrapper.offsetHeight == 0) {
      wrapper.style.height = `${height}px`;
      button.classList.add('expanded');
    } else {
      wrapper.style.height = `0`;
      button.classList.remove('expanded');
    }

  });

  window.addEventListener('resize', resize);

}
