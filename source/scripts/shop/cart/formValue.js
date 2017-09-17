
const form = document.querySelector('form');
const button = form.querySelector('input[type="submit"]');
const value = button.value;
let isMobileValueSet = false;

// Function

function modifyValue() {

  if (window.innerWidth < 480) {

    if (!isMobileValueSet) {
      button.value = 'Proceed';
      isMobileValueSet = true;
    }

  } else {

    button.value = value;
    isMobileValueSet = false;

  }

}

// Export

export default function () {

  window.addEventListener('resize', modifyValue);
  modifyValue();

}
