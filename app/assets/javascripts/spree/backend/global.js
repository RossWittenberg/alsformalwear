var BACKEND_GLOBAL = {
	loaded: function(){
		console.log("backend global loaded");
	},
	tabs: function(){
		console.log("backend tabs loaded");
		var formAction = $('.delete-event-form').attr('action');
		$('#tabs').tabs({
			activate: function(event, ui) {
				console.log(ui);
        window.location.hash = ui.newTab.find('a').attr('href');
				var tabTag = ui.newTab.attr("aria-controls");
				$('.delete-event-form').attr('action', formAction+"&tabtag="+tabTag);
      }
		});
	}
}

$(document).ready(function() {
	BACKEND_GLOBAL.loaded();
	BACKEND_GLOBAL.tabs();
})


// - user feedback for 'update' button on content edit form
// - add breadcrumbs for edit form and page content index

