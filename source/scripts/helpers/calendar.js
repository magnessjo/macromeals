
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
      let removeDelivery = true;

      deliveryDates.forEach( (entry) => {

        // Hack

        if (removeDelivery && !entry.classList.contains('expected-delivery-date')) {
          entry.classList.remove('delivery');
          return;
        } else {
          removeDelivery = false;
        }

        // Event

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
