
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';
import setCalendarDateInput from 'scripts/helpers/setCalendarDateInput.js';

// Variables

const container = document.querySelector('#calendar');
const currentDateClass = 'expected-delivery-date';

// Export

export default function() {

  if (container) {

    const calendars = Array.from(container.querySelectorAll('.calendars'));

    calendars.forEach( (calendar) => {

      const deliveryDates = Array.from(calendar.querySelectorAll('.delivery'));

      deliveryDates.forEach( (entry) => {

        entry.addEventListener('click', () => {

          const currentDate = calendar.querySelector(`.${currentDateClass}`);
          setCalendarDateInput(entry);
          currentDate.classList.remove(currentDateClass);
          entry.classList.add(currentDateClass);

        });

      });

    });

  }

}
