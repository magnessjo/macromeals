
// Import

import postToCart from 'scripts/helpers/cart/postToCart.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';
import inputQuery from 'scripts/helpers/form/inputQuery.js';
import checkSelectFields from 'scripts/helpers/form/checkSelectFields.js';

// Variables

const form = document.querySelector('form#address-info');
const requiredFields = Array.from(form.querySelectorAll('[data-required]'));
const inputs = Array.from(form.querySelectorAll('input[type="text"]'));
const selects = Array.from(form.querySelectorAll('select'));

// Export

export default function() {

  // Event Listeners For Inputs

  checkSelectFields(selects);
  inputQuery(form);

  // Form Submit

  form.addEventListener('submit', (e) => {

    e.preventDefault();

    let shouldScroll = true;
    let fields = requiredFields;

    checkSelectFields(selects, true);
    inputQuery(form, false);

    for (let i = 0; i < fields.length; i++) {

      const elm = fields[i];
      const isValid = elm.getAttribute('valid');

      if (isValid == 'false') {

        if (shouldScroll) {
          scrollToLocation(elm, 120);
          shouldScroll = false;
        }

        return;

      } else {

        if (i == fields.length - 1) {

          form.submit();

          // const id = form.querySelector('input[name="shippingAddressId"]').value;
          // const countryId = form.querySelector('input[name="shippingAddress[countryId]"]').value;
          // let data = `${window.csrfTokenName}=${window.csrfTokenValue}&sameAddress=1&shippingAddressId=${id}&shippingAddress[countryId]=${countryId}`;
          //
          // inputs.forEach( (input) => {
          //
          //   const name = input.getAttribute('name');
          //   const value = input.value;
          //
          //   data += `${name}=${value}&`;
          //
          // });
          //
          // selects.forEach( (select) => {
          //
          //   const name = select.getAttribute('name');
          //   const value = select.options[select.selectedIndex].value;
          //
          //   data += `${name}=${value}`;
          //
          // });
          //
          //
          // console.log(data);
          //
          // postToCart(data).then( (response) => {
          //
          //    window.location.href = '/checkout';
          //
          // });

        }

      }

    }

  });

}
