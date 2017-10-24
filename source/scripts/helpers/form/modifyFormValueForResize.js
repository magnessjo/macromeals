
const url = location.href;
const segment = url.match(/([^\/]*)\/*$/)[1];
let button;
let value;
let data;
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

  button = document.querySelector('input[data-button="continue"]');

  if (button) {

    value = button.value;
    data = button.getAttribute('data-button');

    if (segment == 'process') data = 'submit';
    window.addEventListener('resize', modifyValue);
    modifyValue();

  }


}
