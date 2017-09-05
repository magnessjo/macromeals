
// Variables

const mealController = document.querySelector('.meal-controller');
const categoriesCheckboxContainer = mealController.querySelector('.checkbox-options');
const categoriesFilterOptions = Array.from(categoriesCheckboxContainer.querySelectorAll('input[type="checkbox"]'));
const mealContainer = document.querySelector('.meal-list');
const enteries = Array.from(mealContainer.querySelectorAll('.entry'));

let currentSelectedCategories = [];

// Load DOM Data

// function loadMeals() {
// 
//   const xhr = new XMLHttpRequest();
//   const url = '/meals.json';
//   let postString = '';
//
//   xhr.open('POST', url);
//
//   xhr.onreadystatechange = () => {
//
//     if (xhr.readyState === xhr.DONE) {
//       if (xhr.status === 200) {
//         loadMeals(JSON.parse(xhr.responseText));
//       }
//     }
//
//   }
//
//   currentSelectedCategories.forEach((category, i) => {
//
//     postString += `type=${category}`;
//     if (i != currentSelectedCategories.length - 1) {
//       postString += `&`;
//     }
//
//   });
//
//   xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
//   xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
//   xhr.send(postString);
//
// }

// Filter Enteries By Category

function filterByCategory() {

  if(currentSelectedCategories.length > 0) {

    enteries.forEach((entry) => {

      const type = entry.getAttribute('data-type');
      let shouldShow = false;

      currentSelectedCategories.forEach((cat) => {
        if (type == cat) shouldShow = true;
      });

      if (!shouldShow) {
        entry.style.display = 'none';
      } else {
        entry.style.display = 'block';
      }

    });

  } else {

    enteries.forEach((entry) => { entry.style.display = 'block' });

  }



}

//  Add event for Category filter

function eventFilterCategory() {

  categoriesFilterOptions.forEach((input) => {

    input.addEventListener('change', () => {

      const type = input.getAttribute('value');

      if (input.checked) {
        currentSelectedCategories.push(type);
      } else {
        const index = currentSelectedCategories.indexOf(type);
        if (index > -1) currentSelectedCategories.splice(index, 1);
      }

      filterByCategory();

    });

  });


}

// Export

export default function() {

  // Load

  eventFilterCategory();

}
