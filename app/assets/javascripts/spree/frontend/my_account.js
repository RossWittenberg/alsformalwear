var my_account = {

	onReady: function() {

		function close_accordion_section() {
			$('.accordion-event .accordion-event-section-title').removeClass('active');
			$('.accordion-event .accordion-event-section-content').slideUp(300).removeClass('open');
		}

		$('.accordion-event-section-title').click(function(e) {
			// Grab current anchor value
			var currentAttrValue = $(this).attr('href');

			if($(e.target).is('.active')) {
				close_accordion_section();
			}else {
				close_accordion_section();

				// Add active class to section title
				$(this).addClass('active');
				// Open up the hidden content panel
				$('.accordion-event ' + currentAttrValue).slideDown(300).addClass('open'); 
			}

			e.preventDefault();
		});
	}
};

$(document).ready(my_account.onReady);