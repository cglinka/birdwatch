function initiate_geolocation(){
	navigator.geolocation.getCurrentPosition(handle_geolocation_query);
  // Set cookie with location data
  navigator.geolocation.getCurrentPosition(setGeoCookie);
  document.location.href = "/birdlist";
}

function handle_geolocation_query(position){
	console.log('Lat: ' + position.coords.latitude + ' ' +'Lon: ' + position.coords.longitude);
	document.getElementById("latitude-text").innerHTML="<h4>latitude:  " + position.coords.latitude +"</h4>";
	document.getElementById("longitude-text").innerHTML="<h4>longitude:  " + position.coords.longitude +"</h4>";
}

function setGeoCookie(position) {
  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
  document.cookie = "lat_lng=" + escape(cookie_val);
}

$('#locate-butt').on('click', function(e){
  // // navigator.geolocation.getCurrentPosition(setGeoCookie);
  // alert("cookie set?");
  // console.log("this button was clicked");
  initiate_geolocation();
});