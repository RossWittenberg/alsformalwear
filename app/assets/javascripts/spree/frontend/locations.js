// $.ajax({
//     url: '/locations',
//     data: {'format': 'json'},
//     success: function(data){
//         console.log(data);
//     },
//     failure: function(data){
//         console.log(data);
//     }
// });

function formatLocationCoordinates(location){
    return {
        'latitude' : location.lat,
        'longitude': location.lng
    };
}

function getUserLocationFromIp(){
    return $.post('https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyDncgCpliYaW5kyrrrtRgWX65P7WDmwO3s');
}

function getNearestStore(latlng, locationSource){
    console.log(latlng);
    return $.ajax({
        url: '/locations/nearest',
        data: {
            'format': 'json',
            'location': latlng
        },
        success: function(response){
            var store = response.locations[0];
            store['location_source'] = locationSource;
            Cookies.set('neareststore', store);
            $('body').trigger('neareststorelocated');
        }
    });
}

function html5geolocationSuccess(position) {
    console.log(position);
    var location = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
    };
    Cookies.set('userlocation', location, {expires: 1});
    getNearestStore(formatLocationCoordinates(location), 'html5');
}

function html5geolocationError() {
    console.log('html5 geolocation error');
    getUserLocationFromIp().then(function(response){
        Cookies.set('userlocation', response.location, {expires: 1});
        getNearestStore(formatLocationCoordinates(response.location), 'ip');
    });
}

function getUserLocation(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(html5geolocationSuccess, html5geolocationError);
    } else {
        //browser does not support HTML5 geolocation feature
        html5geolocationError()
    }
}

// Closure
(function() {
    /**
     * Decimal adjustment of a number.
     *
     * @param {String}  type  The type of adjustment.
     * @param {Number}  value The number.
     * @param {Integer} exp   The exponent (the 10 logarithm of the adjustment base).
     * @returns {Number} The adjusted value.
     */
    function decimalAdjust(type, value, exp) {
        // If the exp is undefined or zero...
        if (typeof exp === 'undefined' || +exp === 0) {
            return Math[type](value);
        }
        value = +value;
        exp = +exp;
        // If the value is not a number or the exp is not an integer...
        if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0)) {
            return NaN;
        }
        // Shift
        value = value.toString().split('e');
        value = Math[type](+(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp)));
        // Shift back
        value = value.toString().split('e');
        return +(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp));
    }

    // Decimal round
    if (!Math.round10) {
        Math.round10 = function(value, exp) {
            return decimalAdjust('round', value, exp);
        };
    }
    // Decimal floor
    if (!Math.floor10) {
        Math.floor10 = function(value, exp) {
            return decimalAdjust('floor', value, exp);
        };
    }
    // Decimal ceil
    if (!Math.ceil10) {
        Math.ceil10 = function(value, exp) {
            return decimalAdjust('ceil', value, exp);
        };
    }
})();

function renderMap( $el ) {
    var storeLocation = $('.location-marker');
    var lat = storeLocation.data('lat');
    var lng = storeLocation.data('lng');
    var args = {
        disableDefaultUI: true,
        zoomControl: true,
        zoom        : 14,
        center      : new google.maps.LatLng( lat, lng ),
        mapTypeId   : google.maps.MapTypeId.ROADMAP,
        streetViewControl: false,
        mapTypeControl: false,
        scrollwheel: false
    };
    
    var map = new google.maps.Map( $el[0], args);
    var locationLatLng = {lat: lat, lng: lng };
    var marker = new google.maps.Marker({
    position: locationLatLng,
    map: map,
    icon: "http://maps.google.com/mapfiles/marker_black.png"
  });
};

function getLocationHours(day, locationId) {
  $.ajax({
    url: '/locations/hours',
    data: {'format': 'json', 
           'day': day,
           'location_id': locationId
          },
    success: function(data){
        renderHours(data);
        console.log(data);
    },
    failure: function(data){
      console.log(data);
    }  
  });
};

function renderHours(data){
    var hoursElement = $('.all-hours ');
    hoursElement.empty();
    if (data.open < 12 ){
        hoursElement.html("<i class='fa fa-clock-o' aria-hidden='true'></i>Opens at " + data.open + ":00 am")
    } else if (data.open == 99 ){
        hoursElement.html("<i class='fa fa-clock-o' aria-hidden='true'></i>Closed today" );
    } else {
        hoursElement.html("<i class='fa fa-clock-o' aria-hidden='true'></i>Opens at: " + data.open + ":00 pm")
    }    
}

$(document).ready(function(){

    $('#all-locations-scroll-to-link').click(function(event) {
        if ($(window).width() > 768) {
            var scrollToLocations = $('#header').height() + $('#all-locations-page-container').height() -120;
        } else {
            var scrollToLocations = $('#header').height() + $('#all-locations-page-container').height() -50;
        }
        
        $(document.body).animate({
            'scrollTop': scrollToLocations
        }, 300);
    });
  
    if ($('#location-map').length > 0 ){
        renderMap( $('#location-map') );
    }

    if ( $('.all-hours ').length > 0 ){
        var date = new Date();
        var day  = date.getDay();
        var locationId = $('.all-hours').attr('data-locationId');
        getLocationHours(day, locationId);
    }

    if ( $('#hours-link').length > 0){
        $('#hours-link').click(function(event) {
            var hoursAnchor = $('a#hours');
            console.log("scrolling to hours")
            if ($( window ).width() > 768){
                var offsetSize = 200;
            } else {
                var offsetSize = 75;
            }
            $(document.body).animate({
                'scrollTop':   $(hoursAnchor).offset().top - offsetSize
            }, 300);
        });    
    }

    if ($('.location-directions-button').length > 0){
        $('.location-directions-button').click(function(event) {
            if (BROWSER.isIphone() === "true"){
                var buttonURL = $(this).attr('data-appleMaps');
            } else {
                var buttonURL = $(this).attr('data-googleMaps');
            }
            window.open(buttonURL, '_blank');
        });
    } 

    if ( $('.location-appointment-button').length > 0 )  {
        $('.location-appointment-button').click(function(event) {
            var locationId = $(this).attr('data-locationId');
            var state = $(this).attr('data-state');
            var city = $(this).attr('data-city');
            var storeName = $(this).attr('data-storeName');
            var zipCode = $(this).attr('data-zipCode');
            $('#aptModal').modal('show');
            $('#aptModal').on('shown.bs.modal', function(){
                $('#appointment_location_idSelectBoxItText').attr('data-val', locationId).text( state + ': ' + city + ' - ' + storeName + ' ' + zipCode );
                $('#appointment_location_id option[value=' + self.locationId + ']').attr('selected', 'selected'); //The browser would automatically take care of unselecting the previously selected choice
            });
        });
    }
});



