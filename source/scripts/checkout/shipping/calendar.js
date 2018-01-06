
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';

// Variables

const container = document.querySelector('#calendar');
const deliveryDates = Array.from(container.querySelectorAll('.delivery'));
const deliveryText = container.querySelector('.expected-date');
const currentDateClass = 'expected-delivery-date';
let currentDate = container.querySelector(`.${currentDateClass}`);

function getMonth(month) {

  switch (month) {
    case 0:
      return 'January';
      break;
    case 1:
      return 'February';
      break;
    case 2:
      return 'March';
      break;
    case 3:
      return 'April';
      break;
    case 4:
      return 'May';
      break;
    case 5:
      return 'June';
      break;
    case 6:
      return 'July';
      break;
    case 7:
      return 'August';
      break;
    case 8:
      return 'September';
      break;
    case 9:
      return 'October';
      break;
    case 10:
      return 'November';
      break;
    case 11:
      return 'December';
      break;
  }

}

function getDay(day) {

  switch (day) {
    case 0:
      return 'Sunday';
      break;
    case 1:
      return 'Monday';
      break;
    case 2:
      return 'Tuesday';
      break;
    case 3:
      return 'Wednesday';
      break;
    case 4:
      return 'Thursday';
      break;
    case 5:
      return 'Friday';
      break;
    case 6:
      return 'Saturday';
      break;
  }

}

// Export

export default function() {

  deliveryDates.forEach( (entry) => {

    entry.addEventListener('click', () => {

      const yearData = parseInt(entry.getAttribute('data-year'));
      const dayData = parseInt(entry.getAttribute('data-day'));
      const monthData = parseInt(entry.getAttribute('data-month') - 1);

      const date = new Date(yearData, monthData, dayData);
      const month = getMonth(date.getMonth());
      const dayOfWeek = getDay(date.getDay());
      const day = ('0' + date.getDate()).slice(-2);
      const year = date.getFullYear();

      currentDate.classList.remove(currentDateClass);
      entry.classList.add(currentDateClass);
      currentDate = entry;

      deliveryText.innerHTML = `Your delivery date is ${dayOfWeek}, ${month} ${day}, ${year}.`;

      fetchData(`${window.csrfTokenName}=${window.csrfTokenValue}&deliveryDate=${year}-${date.getMonth() + 1}-${day} 05:00:00`, '/actions/MacroCommerce/Cart/setDeliveryDate').then( (response) => {
        console.log(response);
      });

    });

  });

}
