
// Import

import shippingForm from './shippingForm.js';
import lazyLoadFoodByCategory from 'scripts/common/lazyLoadFoodByCategory.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  lazyLoadFoodByCategory();
  shippingForm();

});
