
// Variables

const slider = document.querySelector('.slider');
const slides = Array.from(slider.querySelectorAll('.slide'));

// Export Function

export default function(index, animation = false) {

  const current = slides[index];

  if (current) {

    const height = current.offsetHeight;

    slider.style.height = `${height + 40}px`;
    current.style.transform = `translateX(-100%)`;

    if (animation) {
      current.style.transition = `transform 1s`;
    }

    if (index != 0 && animation) {
      const previous = slides[index - 1];
      previous.style.transform = `translateX(-200%)`;
      previous.style.transition = `transform 1s`;
    }

  }

}
