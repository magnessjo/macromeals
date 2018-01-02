
// Variables

const form = document.querySelector('#paymentMethod');
const buttons = Array.from(form.querySelectorAll('button'));
const formsWrapper = document.querySelector('#payment-options');
const forms = Array.from(formsWrapper.querySelectorAll('form'));

// Export

export default function() {

  buttons.forEach( (button) => {

    button.addEventListener('click', e => {

      const attr = button.getAttribute('data-attr');
      e.preventDefault();

      forms.forEach( (form) => {

        const id = form.getAttribute('data-id');
        form.style.display = attr != id ? 'none' : 'block';

      });

    });

  });

}
