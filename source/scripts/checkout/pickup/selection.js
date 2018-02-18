
// Variables

const form = document.querySelector('#pickup-options');
const buttons = Array.from(form.querySelectorAll('.options button'));
const calendarContainer = document.querySelector('#calendar');
const calendars = Array.from(calendarContainer.querySelectorAll('.calendar-wrapper'));
const textHeadline = calendarContainer.querySelector('h1');

// Show Calendars

function showCalendar(id, name) {

  calendars.forEach( (calendar) => {

    const attr = calendar.getAttribute('data-calendar');

    if (attr == id) {
      calendar.style.display = 'flex';
    } else {
      calendar.style.display = 'none';
    }

  });

  calendarContainer.style.display = 'block';
  textHeadline.innerHTML = `Select your Delivery Date For ${name}`;

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
            const parent = button.parentNode;
            const name = parent.querySelector('h2');
            btn.setAttribute('data-selected', true);
            btn.innerHTML = 'Selected';
            showCalendar(id, name.innerHTML);
          }

        });

      }

    });

  });

}
