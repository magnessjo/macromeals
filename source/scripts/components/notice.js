
// Variables

const container = document.querySelector('.notice');
const button = container.querySelector('h1');
const wrapper = container.querySelector('.expand-content');

// Export

export default function() {

  button.addEventListener('click', () => {

    const height = wrapper.querySelector('div').offsetHeight;

    if  (wrapper.offsetHeight == 0) {
      wrapper.style.height = `${height}px`;
      button.classList.add('expanded');
    } else {
      wrapper.style.height = `0`;
      button.classList.remove('expanded');
    }

  });

}
