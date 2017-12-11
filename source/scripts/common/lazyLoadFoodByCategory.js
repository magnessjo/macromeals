
import fetchPostData from 'scripts/helpers/fetchPostData.js';

// Variables

const groups = Array.from(document.querySelectorAll('.entries-group'));

// Create Meal

function createMeal(data, parent) {

  data.forEach( (item) => {

    const container = document.createElement('div');
    const link = document.createElement('a');
    const image = document.createElement('img');
    const overlay = document.createElement('div');
    const title = document.createElement('p');
    const detailsText = document.createElement('p');

    // Add properties to container

    container.classList.add('meal-entry');

    // Add properties to image

    container.classList.add('meal-detail');
    link.setAttribute('href', `/shop/details/${item.slug}`);

    // Add properties to link

    const isImage = item.image[0].filename;

    if (isImage) {
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

  });

}

// Get Meals

function getMeals(categoryId, group) {

  const postData = `${window.csrfTokenName}=${window.csrfTokenValue}&id=${categoryId}`;

  fetchPostData(postData, '/actions/MacroCommerce/Food/productByCategory').then( (response) => {

    const entries = Array.reverse(response.entries);
    createMeal(entries, group);

  });

}

export default function() {

  groups.forEach( (group) => {

    const id = group.getAttribute('data-category-id');
    getMeals(id, group);

  });

}
