
// Variables

const form = document.querySelector('#weekly-subscriptions');
const inputs = Array.from(form.querySelectorAll('input[type="number"]'));
const checkoutButton = document.querySelector('.ready-to-checkout');

// Export

export default function() {

  let showButton = false;

  inputs.forEach( (input, i) => {

    if (showButton) return;

    if (input.value > 0) {
      checkoutButton.setAttribute('ready-to-checkout-showing', true);
      showButton = true;
    }

    if (i == inputs.length - 1 && showButton == false) {
      checkoutButton.setAttribute('ready-to-checkout-showing', false);
    }

  });

}
