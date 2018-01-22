
// Variables

const shareOptions = document.querySelector('.options');
const facebookButton = shareOptions.querySelector('.fb-share');

// Load

document.addEventListener('DOMContentLoaded', () => {

  facebookButton.addEventListener('click', () => {

    FB.ui({
      method: 'share',
      mobile_iframe: true,
      href: 'https://www.macromeals.life/',
    }, function(response){});

  });


});
