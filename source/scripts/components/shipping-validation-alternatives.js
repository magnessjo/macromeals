
// Variables

const container = document.querySelector('#shipping-validation-alternatives');
const wrapper = container.querySelector('.alternatives');
const button = container.querySelector('.close');

// User Select Alternative

function populateFormAndSubmit(item, success) {

  const address = document.querySelector('input[name="address"]');
  const city = document.querySelector('input[name="city"]');
  const zip = document.querySelector('input[name="zipCode"]');
  const select = document.querySelector('select[name="state"]');

  address.value = item.addressLine;
  city.value = item.politicalDivision2;
  zip.value = item.postcodePrimaryLow;
  select.value = item.politicalDivision1;

  container.style.display = 'none';

  success();

}

// Create DOM

function createDOM(alternatives, success) {

  wrapper.innerHTML = '';

  alternatives.forEach( (item) => {

    const itemWrapper = document.createElement('div');
    const textWrapper = document.createElement('div');
    const button = document.createElement('button');
    const addressLineOne = document.createElement('p');
    const addressLineTwo = document.createElement('p');

    addressLineOne.innerHTML = `${item.addressLine}`;
    addressLineTwo.innerHTML = `${item.region}`;

    button.innerHTML = 'Select';

    button.addEventListener('click', () => {
      populateFormAndSubmit(item, success);
    });

    textWrapper.appendChild(addressLineOne);
    textWrapper.appendChild(addressLineTwo);

    itemWrapper.appendChild(textWrapper);
    itemWrapper.appendChild(button);
    wrapper.appendChild(itemWrapper);

  });

  container.style.display = 'block';


}

// Export

export default function(alternatives, success, failure) {

  createDOM(alternatives, success);

  const closeEvent = button.addEventListener('click', () => {
    container.style.display = 'none';
    failure();
  });

}
