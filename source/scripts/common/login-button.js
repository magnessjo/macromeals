
// Variables

const header = document.querySelector('header');
const button = header.querySelector('.login');
const loginForm = header.querySelector('.login-form');
const cartSummary = header.querySelector('.cart-summary');

// Export Function

export default function() {

  button.addEventListener('click', () => {

    const isShown = loginForm.getAttribute('aria-hidden');

    if (isShown == 'true') {
      loginForm.setAttribute('aria-hidden', 'false');
      cartSummary.setAttribute('aria-hidden', 'true')
    } else {
      loginForm.setAttribute('aria-hidden', 'true');
    }

  });

}
