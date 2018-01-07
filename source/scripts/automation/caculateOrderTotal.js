
// Variables

const container = document.querySelector('#today');

function updateTotal(foodArray) {

  const totalArray = [];
  const totalContainer = container.querySelector('.total');

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

  totalArray.forEach( (item) => {

    const element = document.createElement('p');
    element.innerHTML = `<span>${item.total}</span> ${item.title}`;

    totalContainer.appendChild(element);

  });


}

// Export

export default function() {

  if (container) {

    const items = Array.from(container.querySelectorAll('.food-item'));
    const foodArray = [];

    items.forEach((item, i) => {
      const index = i;
      const title = item.getAttribute('food-type');
      const total = item.getAttribute('food-total');
      let obj = {index, title, total};
      foodArray.push(obj);
    });

    updateTotal(foodArray);

  }

}
