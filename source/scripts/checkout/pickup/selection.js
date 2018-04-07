
// Imports

import setCalendarDateInput from 'scripts/helpers/setCalendarDateInput.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';

// Variables

const form = document.querySelector('#pickup-options');
const submitButton = form.querySelector('input[type="submit"]');
const buttons = Array.from(form.querySelectorAll('.options button'));
const calendarContainer = document.querySelector('#calendar');
const calendars = Array.from(calendarContainer.querySelectorAll('.calendar-wrapper'));
const textHeadline = calendarContainer.querySelector('h1');
const inputMethod = document.querySelector('input[name="shippingMethodHandle"]');

// Show Calendars

function showCalendar(id, name) {

  calendars.forEach( (calendar) => {

    const attr = calendar.getAttribute('data-calendar');

    if (attr == id) {
      const currentDateSelected = calendar.querySelector(`.expected-delivery-date`);
      calendar.style.display = 'flex';
      setCalendarDateInput(currentDateSelected);
    } else {
      calendar.style.display = 'none';
    }

  });

  calendarContainer.style.display = 'block';
  textHeadline.innerHTML = `Select your Delivery Date For ${name}`;
  submitButton.disabled = false;
  scrollToLocation(calendarContainer, 30);

}

// Export

export default function() {

  buttons.forEach( (button) => {

    button.addEventListener('click', e => {

      e.preventDefault();
      const isSelected = button.getAttribute('data-selected');

      if (isSelected != 'true') {

        buttons.forEach( (btn) => {

          if (btn != button) {
            btn.setAttribute('data-selected', false);
            btn.innerHTML = 'Select';
          } else {
            const id = btn.getAttribute('data-id');
            const method = btn.getAttribute('data-method');
            const parent = button.parentNode;
            const name = parent.querySelector('h2');
            inputMethod.value = method;
            btn.setAttribute('data-selected', true);
            btn.innerHTML = 'Selected';
            showCalendar(id, name.innerHTML);
          }

        });

      }

    });

  });

  // Hack fix for templating language issue

  calendars.forEach( (calendar) => {

    const expectedDates = Array.from(calendar.querySelectorAll('.expected-delivery-date'));

    if (expectedDates.length > 0) {

      expectedDates.forEach( (elm, i) => {

        if (i != 0) elm.classList.remove('expected-delivery-date');

      });

    }

  });

}
