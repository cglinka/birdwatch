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

//Bonnie 

var listTemplateHTML = $("#templates", ".(div class here)");
var listTemplate = _.template();

var Birdlist = Backbone.View.extend ({
	initilize: function (options){
		this.list = options.list;
	},

	render: function (){
<<<<<<< HEAD
		for (var i =0; i< this.list.length; i++){
=======
		for (var i=0; i < this.list.length; i++){
>>>>>>> f51eea1e68630a265ee46f176e761039f86c3f10
			var newListHTML = listTemplate(this.list[i]);
			$(this.el).append(newListHTML);
		}		
	}
}

var blist = new Birdlist(window.birds_json)

