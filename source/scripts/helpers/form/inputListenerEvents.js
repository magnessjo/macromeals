
// Import

import inputValidation from './inputValidation.js';
import findParentNode from 'scripts/helpers/findParentNode.js';

// Export

export default function(form) {

  const inputs = Array.from(form.querySelectorAll('input[type="text"]'));

  inputs.forEach( (input) => {

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
      inputValidation.attachEventHandlers(input, parent, validation);
    }


  });

}
