$(window).load(function(){
    $('.slider-loader-wrapper').fadeOut(300);
});

var theHome = {
 
	sliderListener: function() {
 		$('.bxslider').bxSlider({
 			auto: true,
 			speed: 1000,
 			autoHover: true
 		});

	},

	colorsList: function(){
		if ( $(window).width() < 768 ) {
 			$( "#colors-head, #colors-body" ).insertBefore( "#colors-fst" );
 		}
 		else{
 			$( "#colors-head, #colors-body" ).insertAfter( "#colors-fst" );
 		}
	},

	locationMap: function(){
		
	}

};

var aboutPage = {
	sliderListener: function() {
 		$('.abslider').bxSlider({
 			auto: true,
 			pager: false
 		});

	},
}

$(document).ready(function() {
	theHome.sliderListener();
	theHome.colorsList();

	$( window ).resize(theHome.colorsList);

	aboutPage.sliderListener();
});