
// Import

import findParentNode from 'scripts/helpers/findParentNode.js';

// Export

export default function(selects, checkValue = false) {

  selects.forEach( (select) => {

    const value = select.options[select.selectedIndex].disabled;
    const parent = findParentNode(select, 'field');
    const required = parent.querySelector('.required');

    select.addEventListener('change', (elm) => {
      parent.setAttribute('valid', true);
      parent.setAttribute('has-error', false);
      required.style.display = 'none';
    });

    if (checkValue) {

      if (value) {
        parent.setAttribute('valid', false);
        parent.setAttribute('has-error', true);
        required.style.display = 'block';
      } else {
        parent.setAttribute('valid', true);
        parent.setAttribute('has-error', false);
        required.style.display = 'none';
      }

    }

  });

}
