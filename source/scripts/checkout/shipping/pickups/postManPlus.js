
// Imports

import styles from '../mapStyles.js';

export default function() {

  var location = new google.maps.LatLng(39.467110,-76.313250);

  // Configure the map options in an object

  var mapOptions = {
    zoom: 16,
    disableDefaultUI: false,
    scrollwheel: false,
    navigationControl: false,
    mapTypeControl: false,
    scaleControl: false,
    draggable: false,
    center: location,
    styles: styles
  };

  // Create the map

  var map = new google.maps.Map(document.getElementById('postManPlusMap'),mapOptions);

  // Create a big image for the map

  var icon = {
    path: "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
    fillColor: '#65943f',
    fillOpacity: .6,
    anchor: new google.maps.Point(0,40),
    strokeWeight: 0,
    scale: 1
  }

  // Add marker to the map

  var marker = new google.maps.Marker({
    position: location,
    map: map,
    icon: icon,
    title: 'Post Man Plus'
  });

  google.maps.event.addListener(marker, 'click', function() {
    window.open('https://www.google.com/maps/place/Postman+Plus/@39.4674016,-76.3152994,17z/data=!3m1!4b1!4m7!3m6!1s0x0:0xf0f6718230cd08b7!8m2!3d39.4674016!4d-76.3131107!9m1!1b1', '_blank');
  });

}
