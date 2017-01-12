function renderMap( $el ) {
	var location = $('.location-marker');
	var lat = location.data('lat');
	var lng = location.data('lng');
	var args = {
		disableDefaultUI: true,
    zoomControl: true,
		zoom		: 14,
		center		: new google.maps.LatLng( lat, lng ),
		mapTypeId	: google.maps.MapTypeId.ROADMAP,
		streetViewControl: false,
    mapTypeControl: false,
    scrollwheel: false
	};
	
	var map = new google.maps.Map( $el[0], args);
	var locationLatLng = {lat: lat, lng: lng };
  var marker = new google.maps.Marker({
    position: locationLatLng,
    map: map
  });
};

$(document).ready(function(){
	if ($('.location-map').length > 0 ){
		renderMap( $('.location-map') );
	}
});