
// Import

import setShippingCost from 'scripts/helpers/cart/setShippingCost.js';

// Export

export default function() {

  setShippingCost('baseShippingCost=22.0000').then( (response) => {
    console.log(response)
  });

}
