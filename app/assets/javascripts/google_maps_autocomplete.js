
$(".search-location").each((i, address) => {
  var autocomplete = new google.maps.places.Autocomplete(address, { types: ['geocode'] });
  google.maps.event.addDomListener(address, 'keydown', function(e) {
    if (e.key === "Enter") {
      e.preventDefault();
    }
  });
});
