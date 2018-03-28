
import fetchPostData from 'scripts/helpers/fetchPostData.js';
import findParentNode from 'scripts/helpers/findParentNode.js';
import filterMeals from 'scripts/helpers/filterMeals.js';

// Variables

const groups = Array.from(document.querySelectorAll('.meal-group'));

// Create Meal

function createMeal(data, parent) {

  return new Promise( (resolve, reject) => {

    data.forEach( (item, i) => {

      const container = document.createElement('div');
      const link = document.createElement('a');
      const image = document.createElement('img');
      const overlay = document.createElement('div');
      const title = document.createElement('p');
      const detailsText = document.createElement('p');

      // Add properties to container

      container.classList.add('meal-entry');

      for (const protein in item.protein) {
        const obj = item.protein[protein];
        container.setAttribute(`data-${obj.slug}`, true);
      }

      // Add properties to image

      container.classList.add('meal-detail');
      link.setAttribute('href', `/shop/details/${item.slug}`);

      // Add properties to link

      console.log(item.image);

      if (item.image[0]) {
        image.setAttribute('src', `/uploads/products/${item.image[0].filename}`);
      } else {
        image.setAttribute('src', `/images/products/placeholder-circle.png`);
      }

      image.setAttribute('alt', `image of ${item.title} ${item.subTitle} `);

      // Add properties to overlay

      overlay.classList.add('overlay');

      // Add properties to overlay

      title.classList.add('meal-title');
      title.innerHTML = `<span>${item.title}</span>`;

      // Add properties to Details

      detailsText.innerHTML = 'See Details';

      // Append Children

      overlay.appendChild(title);
      overlay.appendChild(detailsText);

      link.appendChild(image);
      link.appendChild(overlay);

      container.appendChild(link);

      parent.insertBefore(container, parent.childNodes[0]);

      if (i == 0) {
        resolve();
      }

      if (data.length - 1 == i) {

        image.addEventListener('load', e => {
          resolve();
        });

      }

    });

  });

}

// Get Meals

function getMeals(categoryId, group, container, isLast) {

  let postData = `${window.csrfTokenName}=${window.csrfTokenValue}&`;
  let url = '';

  if (categoryId != null) {
    postData += `id=${categoryId}`;
    url = '/productsByCategory';
  } else {
    url = '/actions/macromeals-commerce/food/lastestProducts';
  }

  fetchPostData(postData, url).then( (response) => {

    const entries = Array.reverse(response.entries);
    createMeal(entries, group).then( () => {

      const list = container.querySelector('.meal-list');
      const loader = container.querySelector('.loader');
      const filter = document.querySelector('.meals-controller');
      loader.style.display = 'none';
      list.style.display = 'block';

      if (filter) {
        const inputs = Array.from(filter.querySelectorAll('input[type="checkbox"]'));

        filter.style.opacity = 1;
        inputs.forEach( (input) => input.disabled = false);

        if (isLast) {
          filterMeals();
        }
      }

    });

  });

}

export default function() {

  const numberOfGroups = groups.length - 1;

  groups.forEach( (group, i) => {

    const entriesContainer = group.querySelector('.entries-group');
    const id = entriesContainer.getAttribute('data-category-id');
    getMeals(id, entriesContainer, group, groups.length - 1 == i);

  });

}
