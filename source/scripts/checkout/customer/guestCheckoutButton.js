
// Variables

const section = document.querySelector('#login-options');
const button = section.querySelector('.guest-cta');
const form = document.querySelector('form#register');
const registrationsSection = form.querySelector('.registration-details');

// Export

export default function() {

  button.addEventListener('click', () => {

    section.style.display = 'none';
    form.style.display = 'block';
    registrationsSection.style.display = 'none';

  });

}
