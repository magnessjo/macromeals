
// Variables

const header = document.querySelector('header');
const button = header.querySelector('.register');
const shopActions = header.querySelector('.shop-actions');
const wrapper = shopActions.querySelector('.order-items');
const actionLink = shopActions.querySelector('.call-to-action');

// Fetch

function fetchData() {

  const url = '/actions/MacroCommerce/Cart/getLines';

  return new Promise((resolve, reject) => {

    fetch(url, {
      method: "GET",
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      credentials: "same-origin"
    }).then(function(response) {
      resolve(response.json());
    }, function(error) {
      console.log(`error : ${error.message }`);
    });

  });

}

// Update DOM

function updateDOM(data) {

  return new Promise((resolve, reject) => {

    if (data.length == 0) {
      wrapper.innerHTML = `<p>Your Cart is Empty</p>`;
      actionLink.style.display = 'none';
      resolve();
    }

    data.forEach((content, i) => {

      const div = document.createElement('div');
      const headline = document.createElement('h2');
      const span = document.createElement('span');

      div.classList.add('order-item');

      headline.innerHTML = content.title;
      span.innerHTML = content.size;

      headline.setAttribute('data-attr', content.quantity);

      headline.appendChild(span);
      div.appendChild(headline);
      wrapper.appendChild(div);
      actionLink.style.display = 'block';

      if (i == data.length - 1) {
        resolve();
      }

    });

  });

}

// Remove content

function removeContent() {

  return new Promise((resolve, reject) => {

    wrapper.innerHTML = '';
    resolve();

  });

}

// Export Function

export default function() {

  button.addEventListener('click', () => {

    const isShown = shopActions.getAttribute('aria-hidden');

    if (isShown == 'true') {

      fetchData().then((data) => {
        updateDOM(data).then(() => {
          shopActions.setAttribute('aria-hidden', 'false');
        });
      });

    } else {

      removeContent().then(() => {
        shopActions.setAttribute('aria-hidden', 'true');
      });

    }

  });

}
