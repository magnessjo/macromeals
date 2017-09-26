
// Variables

const container = document.querySelector('.fact-tab');
const buttons = Array.from(container.querySelectorAll('button'));
const content = Array.from(container.querySelectorAll('.fact-info'));

const activeButton = 'active-button';
const activeInfo = 'active-info';

// function

function updateTab(index) {

  buttons.forEach((button) => {

    if (button.classList.contains(activeButton)) {
      button.classList.remove(activeButton);
    } else {
      button.classList.add(activeButton);
    }

  });

  content.forEach((item) => {

    if (item.classList.contains(activeInfo)) {
      item.classList.remove(activeInfo);
    } else {
      item.classList.add(activeInfo);
    }

  });

}

// Export

export default function() {

  console.log(content);

  buttons.forEach((button) => {
    button.addEventListener('click', () => {
      updateTab(buttons.indexOf(button))
    });
  })

}
