
// Variables

const form = document.querySelector('#paymentMethod');
const select = form.querySelector('select');
const formsWrapper = document.querySelector('#payment-options');
const forms = Array.from(formsWrapper.querySelectorAll('form'));

// Export

export default function() {

  select.addEventListener('change', e => {

    const value = select.options[select.selectedIndex].value;

    forms.forEach( (form) => {

      const id = form.getAttribute('data-id');

      if (id == value) {
        form.style.display = 'block';
      } else {
        form.style.display = 'none';
      }

    });

  });

}
