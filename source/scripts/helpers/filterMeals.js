
// Variables

const filteredOut = [];

// Filter DOM

function filterDom(entries) {

  entries.forEach( (entry) => {

    let showShow = true;

    filteredOut.forEach( (cat) => {

      const catString = `data-${cat}`;

      if(entry.hasAttribute(catString)) {
        showShow = false;
      }

    });

    if (showShow == false) {
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
      const ariaHidden = element.getAttribute('aria-hidden');

      if (ariaHidden == 'true') {
        element.setAttribute('aria-hidden', false);
        element.style.display = 'block';
      } else {
        element.setAttribute('aria-hidden', true);
        element.style.display = 'none';
      }

    });

  });

}
