var accordionPanel = {

	onReady: function() {
		$('.collapse').on('shown.bs.collapse', function(){
			$(this).parent().find(".arrow-down").removeClass("arrow-down").addClass("arrow-up");
		}).on('hidden.bs.collapse', function(){
			$(this).parent().find(".arrow-up").removeClass("arrow-up").addClass("arrow-down");
		});
	}
};

$(document).ready(accordionPanel.onReady);