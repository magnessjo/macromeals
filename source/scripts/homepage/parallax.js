
// Variables

const stage = document.querySelector('#stage');
const image = stage.querySelector('.image');

// Scroll

function scroll() {

  const windowPosition = window.scrollY;

  image.style.marginTop = `-${windowPosition/2}px`;

}

// Export

export default function() {

  window.addEventListener('scroll', scroll);

}
