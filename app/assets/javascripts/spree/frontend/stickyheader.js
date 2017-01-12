var STICKYHEADER = {
	getWindowWidth: function(){
		return $(window).width();
	},
		
  onReady: function(){
  	var $window = $(window)
		$window.scroll(function () {
			if( STICKYHEADER.getWindowWidth() < 992 ){
				if ( $('.promo-nav-row').length > 0 ){
					STICKYHEADER.mobileBottomSticky();
				}
				STICKYHEADER.topSticky();
			} else {
				STICKYHEADER.topSticky();
				STICKYHEADER.bottomSticky();
				STICKYHEADER.logoSticky();
			};
		});	
  },
  
  	topSticky: function() {
  		var $window = $(window)
  		var promoNavRow = $(".promo-nav-row").height();

  		if ( !($('.top-nav-row').hasClass('top-stuck') ) && STICKYHEADER.getWindowWidth() > 992  ){
  			$window.scroll(function () {
  				if( $window.scrollTop() > promoNavRow && !($('.top-nav-row').hasClass('top-stuck'))  ){
  					$('.top-nav-row').addClass('top-stuck');
  					$('.nav-logo').addClass('top-stuck');
  				} else if ( $(".top-stuck").length > 0 && $(window).scrollTop() < promoNavRow ){
  					$('.top-nav-row').removeClass('top-stuck');
  					$('.nav-logo').removeClass('top-stuck');
  				}
  			});
  		}
	},

	bottomSticky: function() {
  	var $window = $(window)
		var navLessBottom = $("header").height() - $('.bottom-nav-row-wrapper').height();
    $window.scroll(function () {
		  if( $window.scrollTop() > navLessBottom && !( $('.bottom-nav-row-wrapper').hasClass('bottom-stuck')) && STICKYHEADER.getWindowWidth() > 992  ){
		    $('.bottom-nav-row-wrapper').addClass('bottom-stuck');
		    $('#wrapper').addClass('bottom-stuck');
		    
		  } else if ( $(".bottom-stuck").length > 0 && $(window).scrollTop() < 110 ){
		    $('.bottom-nav-row-wrapper').removeClass('bottom-stuck');
		    $('#wrapper').removeClass('bottom-stuck');
		    
		  }
		});
	},

	logoSticky: function() {
  	var $window = $(window)
		var promoNavRow = $(".promo-nav-row").height();
		$window.scroll(function () {
		  if( $window.scrollTop() > promoNavRow && STICKYHEADER.getWindowWidth() > 992  ){
		  	var logoOpacity = ( 1 / ( $window.scrollTop() * 0.03 )  )
		    $('.nav-logo').css('opacity', logoOpacity );
		    $('.bottom-nav-logo').css('opacity', ( $window.scrollTop() * 0.003 ));
		  } else {
		  	$('.nav-logo').css('opacity', 1);
		  	$('.bottom-nav-logo').css('opacity', 0);
		  }
		});
	},

	bottomNoPromoSticky: function() {
		var $window = $(window)
		if ( STICKYHEADER.getWindowWidth() > 992 ) {
			var navLessBottom = $("header").height() - $('.bottom-nav-row-wrapper').height() - 95;
			$window.scroll(function () {
			  if( $window.scrollTop() > navLessBottom && !( $('.bottom-nav-row-wrapper').hasClass('bottom-stuck')) && STICKYHEADER.getWindowWidth() > 992  ){
			    $('.bottom-nav-row-wrapper').addClass('bottom-stuck');
			    $('#wrapper').addClass('bottom-stuck');
    	    $('.top-nav-row').addClass('top-stuck-no-promo');
	    		$('.nav-logo').addClass('top-stuck-no-promo');

			  } else if ( $(".bottom-stuck").length > 0 && $(window).scrollTop() < navLessBottom ){
			    $('.bottom-nav-row-wrapper').removeClass('bottom-stuck');
			    $('#wrapper').removeClass('bottom-stuck');
			  }
			})
		}	else {
	    //$('.top-nav-row').addClass('top-stuck-no-promo');
	    //$('.mobile.bottom-nav-row-wrapper').addClass('bottom-stuck');
	    //$('#wrapper').addClass('bottom-stuck');
		}
	},

	mobileBottomSticky: function() {
  	var $window = $(window)
		var mobileNavLessBottom = $('.promo-nav-row').height();
		//$('.bottom-nav-row-wrapper.mobile').css({ position: 'relative' });

    $window.scroll(function () {
		  if( $window.scrollTop() > mobileNavLessBottom && !( $('.mobile.bottom-nav-row-wrapper').hasClass('bottom-stuck')) ){
		    $('.mobile.bottom-nav-row-wrapper').addClass('bottom-stuck');
		    $('#wrapper').addClass('bottom-stuck');

		  } else if ( $(".bottom-stuck").length > 0 && $(window).scrollTop() < mobileNavLessBottom ){
		    $('.mobile.bottom-nav-row-wrapper').removeClass('bottom-stuck');
		    $('#wrapper').removeClass('bottom-stuck');
		  }
		});
	}
};

$( document ).ready( STICKYHEADER.onReady );

