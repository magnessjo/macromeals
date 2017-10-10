
// Variables

const section = document.querySelector('#register');
const buttons = Array.from(section.querySelectorAll('.register-cta'));
const infoSection = document.querySelector('#customer-info');

// Export

export default function() {

  buttons.forEach((button) => {

    button.addEventListener('click', () => {

      section.style.display = 'none';
      infoSection.style.display = 'block';

    });

  });

}
