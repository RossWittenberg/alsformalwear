var BUTTONS = {
 
  addListeners: function() {
 		$(".ex").click(function(event) {
 			STICKYHEADER.bottomNoPromoSticky();
			console.log("ex clicked");
			$(this).parent().addClass('hidden')
 		});
	},

	scrollToTopOfForm: function( element ) {
		console.log("scrolling to " + element )
		var formTopElement = element;
    $('html, body').animate({
       scrollTop: $(formTopElement).offset().top - 105
    }, 700);
	}
};

$(document).ready(function() {
	console.log("buttons loaded");
	BUTTONS.addListeners();
});



