
const stylesFiles = [
  '/homepageStyle.css',
  '/macrosStyle.css',
  '/aboutStyle.css',
  '/genericStyle.css',
  '/faqStyle.css',
  '/whyStyle.css',
  '/contactStyle.css',
  '/shippingInstructionsStyle.css',
  '/shopdetailsStyle.css',
  '/orderStyle.css',
  '/mealsStyle.css',
  '/checkoutStyle.css',
  '/labelsStyle.css',
  '/automationStyle.css',
  '/automationSummaryStyle.css',
  '/accountStyle.css',
]

const jsFiles = [
  '/common.js',
  '/homepage.js',
  '/about.js',
  '/faq.js',
  '/contact.js',
  '/why.js',
  '/shippingInstructions.js',
  '/shopdetails.js',
  '/order.js',
  '/meals.js',
  '/automation.js',
  '/customer.js',
  '/pickup.js',
  '/summary.js',
  '/billing.js',
  '/cart.js',
  '/complete.js',
  '/register.js',
]

const files = [...stylesFiles, ...jsFiles];

self.addEventListener('install', function(event) {

  event.waitUntil(

    caches.open('v1').then( function(cache) {

      return cache.addAll(files);

    })

  );

});
