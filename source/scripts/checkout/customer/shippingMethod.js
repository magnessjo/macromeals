
// Variables

const form = document.querySelector('form#address-info');
const container = document.querySelector('#shipping-method');
const buttons = Array.from(container.querySelectorAll('.shpping-type'));
const input = container.querySelector('input[name="shippingMethod"]');
const activeState = 'data-active';
let handle = '';

// Export

export default function() {

  buttons.forEach( (button) => {

    button.addEventListener('click', () => {

      const state = button.getAttribute(activeState);

      if (state == 'true') return;

      buttons.forEach( (btn) => {

        if (btn == button) {
          btn.setAttribute(activeState, true);
          handle = btn.getAttribute('data-handle');
        } else {
          btn.setAttribute(activeState, false);
        }

      });

      input.value = handle;
      if (handle == 'pickup') {
        form.setAttribute('data-method', 'pickup');
      } else {
        form.setAttribute('data-method', '');
      }

    });

  });

}
