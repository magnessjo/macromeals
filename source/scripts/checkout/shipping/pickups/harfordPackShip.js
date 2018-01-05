
// Imports

import styles from '../mapStyles.js';

export default function() {

  var location = new google.maps.LatLng(39.534975,-76.3466113);

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

  var map = new google.maps.Map(document.getElementById('harfordPackMap'),mapOptions);

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
    title: 'Harford Pack & Ship'
  });

  google.maps.event.addListener(marker, 'click', function() {
    window.open('https://www.google.com/maps/place/Harford+Pack+%26+Ship/@39.5368548,-76.3499856,17.19z/data=!4m12!1m6!3m5!1s0x0:0x4c98b3c65231cd99!2sUnited+States+Postal+Service!8m2!3d39.5288131!4d-76.3614044!3m4!1s0x0:0xbfee7307036b8e3!8m2!3d39.534975!4d-76.3466113', '_blank');
  });
}
