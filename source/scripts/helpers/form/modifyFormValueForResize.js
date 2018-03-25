
const url = location.href;
const segment = url.match(/([^\/]*)\/*$/)[1];
let button;
let value;
let data;
let text;
let isMobileValueSet = false;

// Function

function modifyValue() {

  if (window.innerWidth < 480) {

    if (!isMobileValueSet) {
      text == '' ? button.value = data : button.innerHTML = data;
      isMobileValueSet = true;
    }

  } else {

    text == '' ? button.value = value : button.innerHTML = text;
    isMobileValueSet = false;

  }

}

// Export

export default function () {

  button = document.querySelector('[data-button="continue"]');

  if (button) {

    text = button.innerHTML;
    value = button.value;
    data = button.getAttribute('data-button');

    window.addEventListener('resize', modifyValue);
    modifyValue();

  }


}
