
// Import

// import filter from './filter.js';
import shippingModal from './shippingModal.js';
import lazyLoadFoodByCategory from 'scripts/common/lazyLoadFoodByCategory.js';

// Load

document.addEventListener('DOMContentLoaded', () => {

  // filter();

  lazyLoadFoodByCategory();
  shippingModal();

});
