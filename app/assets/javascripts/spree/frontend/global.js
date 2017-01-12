// Configure Underscore to use {{- }} as the escape tags, since the default <%= %> tags are processed by ERB & hence cannot be used here
_.templateSettings.escape = /\{\{-(.*?)\}\}/g
_.templateSettings.evaluate = /\{\{(.*?)\}\}/g

//Add a function to jQuery so we can fetch the URL params
$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (results==null){
    return null;
    }
    else{
        return results[1] || 0;
    }
};

var btyMobile = {

	onReady: function() {

		var smallBreak = 768; 
		var $iW = $(window).innerWidth();

		if ($iW < smallBreak){
			$(".bytheader").find(".push_down").insertAfter(".bytheader .right_img");
			$(".bytheader").find("button").removeClass("button-primary").addClass("button-secondary");
		}else{
			$(".bytheader").find(".push_down").insertBefore(".bytheader .right_img");
			$(".bytheader").find("button").removeClass("button-secondary").addClass("button-primary");
		}


	}

};

$(document).ready(btyMobile.onReady);

function displayNearestStoreInHeader(){
    var store = Cookies.getJSON('neareststore');
    $('#top-nav-store-name').text(store['store_name'] + ', ' + store['city']).attr('data-location-id', store.id);
    $('#top-nav-store-phone').text(store['phone_number']);
    prepopulateNearestStoreInApptModal(store);
}

function prepopulateNearestStoreInApptModal(store){
    console.log('populating appt. modal');
    console.log(store);

    $('#aptModal').on('shown.bs.modal', function(){
        console.log('inside modal shown');
        console.log($('all-locations-page-container').length);
        console.log('store is');
        console.log(store);
        if(!$('all-locations-page-container').length > 0){
            $('#appointment_location_idSelectBoxItText').attr('data-val', store.id).text(store.state + ': ' + store.city + ' - ' + store.store_name + ' ' + store['zip_code']);
            $('#appointment_location_id option[value=' + store.id + ']').attr('selected', 'selected'); //The browser would automatically take care of unselecting the previously selected choice
            console.log($('#appointment_location_id'));
            console.log($('#appointment_location_id').val());
        }   
    });
}

function openInNewTab(url) {
    var win = window.open(url, '_blank');
    win.focus();
}

function getURLSearchParameters() {
    var prmstr = window.location.search.substr(1);
    return prmstr != null && prmstr != "" ? transformToAssocArray(prmstr) : {};
}

function transformToAssocArray( prmstr ) {
    var params = {};
    var prmarr = prmstr.split("&");
    for ( var i = 0; i < prmarr.length; i++) {
        var tmparr = prmarr[i].split("=");
        if(tmparr[0].search(/\[\]/) !== -1){
            if(typeof params[tmparr[0]] === 'undefined'){
                params[tmparr[0]] = [];
            }
            params[tmparr[0]].push(decodeURIComponent(tmparr[1]));
        } else {
            params[tmparr[0]] = decodeURIComponent(tmparr[1]);
        }
    }
    return params;
}

window.urlParams = getURLSearchParameters();

$(document).ready(function(){
    $('body').on('neareststorelocated', function() {
        displayNearestStoreInHeader();
    });
    if(Cookies.get('neareststore') != undefined){
        displayNearestStoreInHeader()
    } else {
        getUserLocation()
    }
    $('button.close').click(function(event) {
        $(".message-wrapper").empty().removeClass('alert').removeClass('success');
        $(":input",".appointment-form").val("").removeAttr('selected');

    });

    $('.top-nav-link-wrapper.location').on('click', function(){
        window.location.href = '/locations/?location_id=' + $('#top-nav-store-name').attr('data-location-id');
    });

    $('.top-nav-link-wrapper.phone').on('click', function(){
        openInNewTab('tel:' + $('#top-nav-store-phone').text());
    });


    $(".datepicker,#prom-rep-date-picker").datepicker();
});



