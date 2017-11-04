
// Variables

const container = document.querySelector('.notice');
let text;
let button;
let wrapper;
let padding;

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

  if (container) {

    text = container.querySelector('.text');
    button = container.querySelector('.toggle');
    wrapper = container.querySelector('.expand-content');
    padding = parseInt(window.getComputedStyle(text).getPropertyValue('padding-top'));

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

}
