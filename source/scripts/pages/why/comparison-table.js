
// Variables

const container = document.querySelector('.comparison-table');
const groups = Array.from(container.querySelectorAll('[data-type="table"]'));
const names = Array.from(container.querySelectorAll('.name'));
const types = Array.from(container.querySelectorAll('.types'));
const costs = Array.from(container.querySelectorAll('.cost'));
const deliveryCosts = Array.from(container.querySelectorAll('.delivery-cost'));
const macros = Array.from(container.querySelectorAll('.macros'));

const cells = [names, types, costs, deliveryCosts, macros];


// Export

export default function() {

  cells.forEach( (cell) => {

    let height = 0;

    cell.forEach( (item) => {
      height = height > item.offsetHeight ? height : item.offsetHeight;
    });

    cell.forEach( (item) => {
      item.style.height = `${height}px`;
    });

  });

}
