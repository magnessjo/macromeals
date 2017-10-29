
// Variables

const stripe = Stripe('pk_test_UrlLqyCEbnu4hXNhRRFaA16n');
const form = document.querySelector('form#payment');
const submitButton = form.querySelector('input[type="submit"]');
const costString = form.getAttribute('data-cost');
const totalCostInCents = costString * 100;
const paymentRequest = stripe.paymentRequest({
  country: 'US',
  currency: 'usd',
  total: {
    label: 'Macro Meals Purchase',
    amount: totalCostInCents,
  },
});

// Stripe Callback

function stripeCallback(status, response) {

  console.log(status);
  console.log(response);

  if (response.error) {

    console.log(response.error);

    submitButton.disabled = false;

  } else {

    const token = response.id;
    const input = document.createElement('input');

    input.setAttribute('type', 'hidden');
    input.setAttribute('name', 'stripeToken');
    input.value = token;

    form.submit();

  }

}

// Add digital payment

function digitalPayment() {

  const container = document.querySelector('.digital-payments');
  const wrapper = container.querySelector('.types');

  // paymentRequest.canMakePayment().then( (result) => {
  //
  //   console.log(result);
  //
  // });


}

// Export

export default function() {

  digitalPayment();

  form.addEventListener('submit', (e) => {

    e.preventDefault();
    submitButton.disabled = true;
    Stripe.card.createToken(form, stripeCallback);

    return false;

  });

}
