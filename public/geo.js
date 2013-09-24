// Set cookie with location data on page load.
navigator.geolocation.getCurrentPosition(setGeoCookie);

function initiate_geolocation(){
  document.location.href = "/birdlist";
}

// Function to set cookie based on HTML5 location data
function setGeoCookie(position) {
  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
  document.cookie = "lat_lng=" + escape(cookie_val);
}

// Click handler for button.
$('#locate-butt').on('click', function(e){
  initiate_geolocation();
});
