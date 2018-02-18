
// Imports

import setCalendarDateInput from 'scripts/helpers/setCalendarDateInput.js';

// Variables

const calendar = document.querySelector('#calendar');

// Export

export default function() {

  if (calendar) {

    const dateInput = document.querySelector('input[name="fields[deliveryDate][date]"]');
    const currentDateSelected = calendar.querySelector(`.expected-delivery-date`);
    setCalendarDateInput(currentDateSelected);

  }

}
