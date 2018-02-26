
// Import

import findParentNode from 'scripts/helpers/findParentNode.js';

// Variables

const filteredOut = [];

// Filter DOM

function filterDom(entries) {

  entries.forEach( (entry, i) => {

    let shouldShow = true;

    filteredOut.forEach( (cat) => {

      const catString = `data-${cat}`;

      if(entry.hasAttribute(catString)) {
        shouldShow = false;
      }

    });

    if (shouldShow == false) {
      entry.style.display = 'none';
    } else {
      entry.style.display = 'block';
    }

  });

}

// Export

export default function() {

  const filter = document.querySelector('.filters');
  const typesContainer = filter.querySelector('.types');
  const proteinContainer = filter.querySelector('.protein');
  const proteinInputs = Array.from(proteinContainer.querySelectorAll('input[type="checkbox"]'));
  const catInputs = Array.from(typesContainer.querySelectorAll('input[type="checkbox"]'));

  proteinInputs.forEach( (input) => {

    input.addEventListener('change', e => {

      e.preventDefault();
      const entries = Array.from(document.querySelectorAll('.meal-entry'));
      const value = input.value;

      if(input.checked) {
        const index = filteredOut.indexOf(value);
        filteredOut.splice(index, 1);
      } else {
        filteredOut.push(value);
      }

      filterDom(entries);

    });

  });

  catInputs.forEach( (input) => {

    input.addEventListener('change', e => {

      e.preventDefault();

      const value = input.value;
      const element = document.querySelector(`div[data-group="${value}"]`);
      const entries = element.querySelector('.entries-group');
      const ariaHidden = element.getAttribute('aria-hidden');

      if (ariaHidden == 'true') {
        element.setAttribute('aria-hidden', false);
        entries.style.display = 'grid';
      } else {
        element.setAttribute('aria-hidden', true);
        entries.style.display = 'none';
      }

    });

  });

}
