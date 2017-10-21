
// Import

import inputValidation from './inputValidation.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Export

export default function(form, attachEvents = true) {

  const inputs = Array.from(form.querySelectorAll('input'));

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
