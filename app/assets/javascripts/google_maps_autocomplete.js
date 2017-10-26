
var address = document.getElementById('search_loc');
var autocomplete = new google.maps.places.Autocomplete(address, { types: ['geocode'] });
google.maps.event.addDomListener(address, 'keydown', function(e) {
  if (e.key === "Enter") {
    e.preventDefault();
  }
});

