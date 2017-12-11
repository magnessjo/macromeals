
// Import

import shippingForm from './shippingForm.js';
import lazyLoadFoodByCategory from 'scripts/common/lazyLoadFoodByCategory.js';
import moveToShipping from './moveToShipping.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  lazyLoadFoodByCategory();
  shippingForm();
  moveToShipping();

});
