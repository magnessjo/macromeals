
// Variables

const form = document.querySelector('form#payment');
const button = form.querySelector('button');

// Stripe Callback

function stripeCallback(status, response) {

  if (response.error) {

    console.log(response.error);

    button.disabled = false;

  } else {

    const token = response.id;
    const input = document.createElement('input');

    input.setAttribute('type', 'hidden');
    input.setAttribute('name', 'stripeToken');
    input.value = token;

    form.submit();

  }

}

// Export

export default function() {

  Stripe.setPublishableKey('YOUR_PUBLISHABLE_KEY');

  form.addEventListener('submit', (e) => {

    e.preventDefault();
    button.disabled = true;
    Stripe.card.createToken(form, stripeCallback);

    return false;

  });

}
