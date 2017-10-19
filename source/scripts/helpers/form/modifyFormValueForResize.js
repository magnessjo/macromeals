
const button = document.querySelector('input[data-button="continue"]');
const value = button.value;
const url = location.href;
const segment = url.match(/([^\/]*)\/*$/)[1];
let data = button.getAttribute('data-button');
let isMobileValueSet = false;

// Function

function modifyValue() {

  if (window.innerWidth < 480) {

    if (!isMobileValueSet) {
      button.value = data;
      isMobileValueSet = true;
    }

  } else {

    button.value = value;
    isMobileValueSet = false;

  }

}

// Export

export default function () {

  if (segment == 'process') data = 'submit';
  window.addEventListener('resize', modifyValue);
  modifyValue();

}
