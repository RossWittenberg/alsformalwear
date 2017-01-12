var MOBILENAV = {
	onReady: function(){
		$('.mainMenu').on('click', function(event){
		  event.preventDefault();
		  toggleMobileMenu();
		  toggleSearch('close');
		  $('body').toggleClass('full-height');
		  $('.bottom-nav-row-wrapper').toggleClass('menu-closed');
		});

		$('.has-children ul li a, .item-dark a, .accordion-menu li a').on('click', function(event){
			toggleMobileMenu();
			toggleSearch('close');
			$('body').removeClass('full-height');
			$('.bottom-nav-row-wrapper').toggleClass('menu-closed');
		});

		var accordionsMenu = $('.accordion-menu');

		if( accordionsMenu.length > 0 ) {

			accordionsMenu.each(function(){
				var accordion = $(this);
			//detect change in the input[type="checkbox"] value
				accordion.on('change', 'input[type="checkbox"]', function(){
					var checkbox = $(this);
					console.log(checkbox.prop('checked'));
					if( checkbox.prop('checked') ) {
						//$('.accordion-menu .has-children ul').slideUp(300);
						checkbox.siblings('ul').attr('style', 'display:none;').slideDown(300);
						checkbox.siblings('h4').show();
					}
					else {
						checkbox.siblings('ul').attr('style', 'display:block;').slideUp(300);
						checkbox.siblings('h4').delay(500).hide();
					}
				});
			});
		}

		$('.search-trigger').on('click', function(event){
			event.preventDefault();
			toggleSearch();
			toggleMobileMenu('close');
		});

		function toggleMobileMenu(type){
			if(type=="close"){
				if ($(window).width() < 768 ) {
					$('#wrapper').toggleClass('fixed');
				}
				$('.menuBtn').removeClass('activeMenu');
	  		$('.mobileNav').removeClass('showNav');
			} else {
				$('.menuBtn').toggleClass('activeMenu');
	  		$('.mobileNav').toggleClass('showNav');
		  		if ($('.mobile.bottom-nav-row-wrapper').hasClass('menu-closed')) {
			  		$('#wrapper').delay(750).queue(function(){
			  			if ($(window).width() < 768 ) {
						  	$(this).toggleClass('fixed');
						  }
					  	$(this).dequeue();
					  });
			  	} else {
			  		if ($(window).width() < 768 ) {
			  			$('#wrapper').toggleClass('fixed');
			  		}
			  	}
			}
		}

		function toggleSearch(type) {
			if(type=="close") {
				//close search 
				$('.mobile-input-search').removeClass('is-visible');
				$('.search-trigger').removeClass('search-is-visible');
				$('.mob-overlay').removeClass('search-is-visible');
				//$('.cd-primary-nav').children('.has-children').children('a.selected').removeClass('selected').next('ul').addClass('is-hidden').end().parent('.has-children').parent('ul').removeClass('moves-out');
			} else {
				//toggle search visibility
				$('.mobile-input-search').toggleClass('is-visible');
				$('.search-trigger').toggleClass('search-is-visible');
				$('.mob-overlay').toggleClass('search-is-visible');
				if($('.mobile-input-search').hasClass('is-visible')) 
					$('.mobile-input-search').find('input[type="search"]').focus();
					($('.mobile-input-search').hasClass('is-visible')) ? $('.mob-overlay').addClass('is-visible') : $('.mob-overlay').removeClass('is-visible') ;
			}
		}

		//prevent default clicking on direct children of .cd-primary-nav 
		$('.cd-primary-nav').children('.has-children').children('a').on('click', function(event){
			event.preventDefault();
		});
		//open submenu
		$('.has-children').children('a').on('click', function(event){
			//if( !checkWindowWidth() ) event.preventDefault();
			var selected = $(this);
			if( selected.next('ul').hasClass('is-hidden') ) {
				//desktop version only
				selected.addClass('selected').next('ul').removeClass('is-hidden').end().parent('.has-children').parent('ul').addClass('moves-out');
				selected.parent('.has-children').siblings('.has-children').children('ul').addClass('is-hidden').end().children('a').removeClass('selected');
				//$('.cd-overlay').addClass('is-visible');
			} else {
				selected.removeClass('selected').next('ul').addClass('is-hidden').end().parent('.has-children').parent('ul').removeClass('moves-out');
				//$('.cd-overlay').removeClass('is-visible');
			}
			toggleSearch('close');
		});

		$(document).on('click', function(event){
			( !$(event.target).is('.has-children') && !$(event.target).is('.has-children a') ) && $('.has-children a.selected').removeClass('selected').next('ul').addClass('is-hidden').end().parent('.has-children').parent('ul').removeClass('moves-out');
		});
	},	  
};

$(document).ready(MOBILENAV.onReady);
