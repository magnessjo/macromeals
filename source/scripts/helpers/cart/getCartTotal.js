
// Import

import fetchData from 'scripts/helpers/fetchPostData.js';

// All Items and Adjustments

function allItemsWithAdjustments() {

  return new Promise((resolve, reject) => {

    fetchData(``, '/actions/MacroCommerce/Cart/getCartTotal').then( (response) => {
      resolve(response);
    });

  });

}

const obj = {
  allItemsWithAdjustments,
}

export default obj;
