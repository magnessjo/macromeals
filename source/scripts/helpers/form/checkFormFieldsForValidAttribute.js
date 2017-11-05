
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';

// Export

export default function(inputs) {

  let isValid = true;

  inputs.forEach( (input) => {

    const parent = findParentNode(input, 'field');
    const valid = parent.getAttribute('valid');

    if (valid == 'false') isValid = false;

  });

  return isValid;

}
