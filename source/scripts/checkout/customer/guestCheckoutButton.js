
// Variables

const section = document.querySelector('#register');
const button = section.querySelector('.guest-cta');
const infoSection = document.querySelector('#customer-info');
const form = document.querySelector('form#register');
const registrationsSection = form.querySelector('.registration-details');

// Export

export default function() {

  button.addEventListener('click', () => {

    section.style.display = 'none';
    infoSection.style.display = 'block';
    registrationsSection.style.display = 'none';

  });

}
