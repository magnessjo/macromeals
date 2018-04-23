
// Variables

const container = document.querySelector('#today');
let totalsContainer;
let steakContainer;
let turkeyContainer;
let chickenContainer;
let veganContainer;
let otherContainer;
let containers;

function postTotals() {

  setTimeout( () => {

    containers.forEach( (container) => {

      const headline = container.querySelector('h2');
      const spans = Array.from(container.querySelectorAll('span'));
      const info = document.createElement('span');
      let totalForCat = 0;

      spans.forEach( (span) => {
        totalForCat += parseInt(span.innerHTML);
      });

      info.innerHTML = ` : ${totalForCat} total meals`;

      headline.appendChild(info);

    });

  }, 500);

}

function updateTotal(foodArray) {

  const totalArray = [];

  const grouping = foodArray.reduce( (obj, item) => {

    obj[item.title] = obj[item.title] || [];
    obj[item.title].push(item.total);
    return obj;

  }, {});

  for (const key in grouping) {
    const arrayOfTotals = grouping[key];
    let combindedTotal = 0;

    arrayOfTotals.forEach( (number) => { combindedTotal += parseInt(number) });
    const obj = { title : key, total : combindedTotal }
    totalArray.push(obj);
  }

  totalArray.sort(function(a, b) {
      var textA = a.title.toUpperCase();
      var textB = b.title.toUpperCase();
      return (textA < textB) ? -1 : (textA > textB) ? 1 : 0;
  });

  totalArray.forEach( (item, i) => {

    const element = document.createElement('p');
    element.innerHTML = `<span>${item.total}</span> ${item.title}`;

    foodArray.forEach( (entry) => {

      if (entry.title == item.title) {

        if (entry.protein == 'Chicken') {
          chickenContainer.appendChild(element);
        }

        if (entry.protein == 'Steak') {
          steakContainer.appendChild(element);
        }

        if (entry.protein == 'Vegan') {
          veganContainer.appendChild(element);
        }

        if (entry.protein == 'Turkey') {
          turkeyContainer.appendChild(element);
        }

        if (entry.protein == 'Other') {
          otherContainer.appendChild(element);
        }

        if (totalArray.length - 1 == i) {
          postTotals();
        }

      }

    });

  });


}

// Export

export default function() {

  if (container) {

    totalsContainer = document.querySelector('.total');
    steakContainer = totalsContainer.querySelector('.Steak');
    turkeyContainer = totalsContainer.querySelector('.Turkey');
    chickenContainer = totalsContainer.querySelector('.Chicken');
    veganContainer = totalsContainer.querySelector('.Vegan');
    otherContainer = totalsContainer.querySelector('.Other');
    containers = [steakContainer, turkeyContainer, chickenContainer, veganContainer, otherContainer];

    const items = Array.from(container.querySelectorAll('.food-item'));
    const foodArray = [];

    items.forEach((item, i) => {
      const index = i;
      const title = item.getAttribute('food-type');
      const total = item.getAttribute('food-total');
      const protein = item.getAttribute('data-protein');
      let obj = {index, title, total, protein};
      foodArray.push(obj);
    });

    updateTotal(foodArray);

  }

}
