

function initiate_geolocation(){
	navigator.geolocation.getCurrentPosition(handle_geolocation_query);
  navigator.geolocation.getCurrentPosition(setGeoCookie);
  document.location.href = "/birdlist";
}

function handle_geolocation_query(position){
	console.log('Lat: ' + position.coords.latitude + ' ' +'Lon: ' + position.coords.longitude);
	document.getElementById("latitude-text").innerHTML="<h4>latitude:  " + position.coords.latitude +"</h4>"
	document.getElementById("longitude-text").innerHTML="<h4>longitude:  " + position.coords.longitude +"</h4>"
};

function setGeoCookie(position) {
  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
  document.cookie = "lat_lng=" + escape(cookie_val);
}

//Bonnie 

var listTemplateHTML = $('#templates .birdTemplate').html();
var listTemplate = _.template(listTemplateHTML);

var Birdlist = Backbone.View.extend({
	initilize: function (options){
		this.list = options.list;
	},

	render: function (){
		for (var i=0; i < this.options.list.length; i++){

			var newListHTML = listTemplate(this.options.list[i]);
			$(this.el).append(newListHTML);
		}		
	}
});

$('#locate-butt').on('click', function(e){
  console.log("this button was clicked");
  initiate_geolocation();
});

//var blist = new Birdlist(window.birds_json)

var testList =[
    {
        "comName": "Yellow-crowned Night-Heron",
        "sciName": "Nyctanassa violacea",
        "img_src": "http://farm3.staticflickr.com/2453/4034562092_66c80760dc.jpg"
    },
    {
        "comName": "White-winged Dove",
        "sciName": "Zenaida asiatica",
        "img_src": "http://farm8.staticflickr.com/7091/7338226784_acb7f13611.jpg"
    },
    {
        "comName": "Rock Pigeon",
        "sciName": "Columba livia",
        "img_src": "http://farm4.staticflickr.com/3023/2367694753_cb4a50b22f.jpg"
    }];

var blist = new Birdlist({
  list: window.birds,
  el: $('.all-search-results')
});
blist.render();


