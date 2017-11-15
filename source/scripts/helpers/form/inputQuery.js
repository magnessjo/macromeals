
// Import

import inputValidation from './inputValidation.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Remove Each Input from Validation if Shipping Method is Pickup

function checkInputAganistList(inputs) {

  const remove = [];

  inputs.forEach( (input) => {

    const id = input.getAttribute('id');
    if (id == 'address1' || id == 'city' || id == 'zipCode') {
      const parent = findParentNode(input, 'field');
      parent.setAttribute('valid', true);
      remove.push(input);
    }

  });

  inputs = inputs.filter( (item) => {
    return !remove.includes(item);
  });

  return inputs;

}

// Export

export default function(form, attachEvents = true) {

  const isFormWithShippingMethod = form.getAttribute('shipping-method');
  let inputs = Array.from(form.querySelectorAll('input:not([type="submit"])'));

  if (attachEvents == false && isFormWithShippingMethod == 'pickup') {
    inputs = checkInputAganistList(inputs);
  }

  inputs.forEach( (input) => {

    const type = input.getAttribute('type');

    if (type == 'submit' || type == 'hidden' || type == 'checkbox') return;

    const parent = findParentNode(input, 'field');
    const isRequired = parent.getAttribute('data-required');

    const attString = input.getAttribute('validation');
    const attributes = attString ? attString.split(',') : [];
    const validation = [];

    if (parent) {

      if (isRequired) validation.push('required');

      if (attributes.length > 0) {
        attributes.forEach((attr, i) => { validation.push(attr) });
      }

    }

    if (validation.length > 0) {

      if (attachEvents) {
        inputValidation.attachEventHandlers(input, parent, validation);
      } else {
        inputValidation.checkFormValues(input, parent, validation);
      }

    }

  });

}
