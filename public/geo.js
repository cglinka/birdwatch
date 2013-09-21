$(window).ready(function(){
	$("#btnInit").click(initiate_geolocation);
});

function initiate_geolocation(){
	navigator.geolocation.getCurrentPosition(handle_geolocation_query);
  navigator.geolocation.getCurrentPosition(setGeoCookie);
}

function handle_geolocation_query(position){
	//console.log('Lat: ' + position.coords.latitude + ' ' +'Lon: ' + position.coords.longitude);
	document.getElementById("lat").innerHTML="<h2>latitude:  " + position.coords.latitude +"</h2>"
	document.getElementById("long").innerHTML="<h2>longitude:  " + position.coords.longitude +"</h2>"
};

function setGeoCookie(position) {
  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
  document.cookie = "lat_lng=" + escape(cookie_val);
}


