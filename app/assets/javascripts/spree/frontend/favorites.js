var FAVORITES = {
	addIndividualProductPAgeListener: function() {
 		$('.individual-product.heart-wrapper').click(function(event) {
 			var variantId = $(this).attr('id');
 			var favorite = $(this).data('favorite');
 			if (favorite === "true" || favorite === true ){
 				var ajaxType = 'PUT';
 				var url = '/favorites/individual_product_destroy';
 				var data = { 'variantId': variantId }
 			} else {
 				var ajaxType = 'POST';
 				var url = '/favorites';
 				var data = { 'variantId': variantId }
 			};
 			FAVORITES.heartToSpinner($(this));
 			$.ajax({
 				url: url,
 				type: ajaxType,
 				dataType: 'json',
 				data: data
 			})
 			.success(function(data) {
 				console.log(data);
 				FAVORITES.cancelLoader(data);
 				FAVORITES.toggleFavorite(data);
 			})
 		});
	},	

	addListeners: function() {
 		console.log("favorites loaded");
 		$('.heart-wrapper').hover(
 			function(event) {
	 			var variantId = $(this).attr('id');
	 			var favorite = $(this).data('favorite');
	 			var removeText = $(this).parent().find('#remove-from-text-'+variantId);
	 			var addText = $(this).parent().find('#add-to-text-'+variantId);
	 			if ( favorite === true || favorite === 'true') {
	      	removeText.removeClass('hidden').show().css({
	      		right: '55px',
	      		opacity: '1'
	      	});
	 			} else {
	      	addText.removeClass('hidden').show().css({
	      		right: '55px',
	      		opacity: '1'
	      	});
	 			};
 			}, function(event) {
	 			var variantId = $(this).attr('id');
	 			var favorite = $(this).data('favorite');
	 			var removeText = $(this).parent().find('#remove-from-text-'+variantId);
	 			var addText = $(this).parent().find('#add-to-text-'+variantId);
	 			if ( favorite === true || favorite === 'true') {
	      	removeText.addClass('hidden').hide().css({ right: '0' }).css('opacity', '0');
	 			} else {
	      	addText.addClass('hidden').hide().css({ right: '0' }).css('opacity', '0');
	 			};
 		});
 		$('.heart-wrapper').click(function(event) {
 			var variantId = $(this).attr('id');
 			var favorite = $(this).data('favorite');
 			if (favorite === "true" || favorite === true ){
 				var ajaxType = 'DELETE';
 				var url = '/favorites/'+variantId;
 				var data = { 'variantId': variantId, 'favoriteId': $(this).data('favorite-id') }
 			} else {
 				var ajaxType = 'POST';
 				var url = '/favorites';
 				var data = { 'variantId': variantId }
 			};
 			FAVORITES.heartToSpinner($(this));
 			$.ajax({
 				url: url,
 				type: ajaxType,
 				dataType: 'json',
 				data: data
 			})
 			.success(function(data) {
 				FAVORITES.cancelLoader(data);
 				FAVORITES.toggleFavorite(data);
 			})
 			.fail(function() {
 				console.log("error");
 			})
 			.always(function() {
 				console.log("complete");
 			});
 		});
	},
	toggleFavorite: function(data){
		var redHeart = $('.red-heart#'+data.variantId);
		var greyHeart = $('.grey-heart.heart-'+data.variantId);
		if (data.favorite === true || data.favorite === "true"){
			$(redHeart).removeClass('hidden').show().data('favorite-id', data.favoriteId).data('favorite', 'true' );
			$(greyHeart).addClass('hidden').hide();
		} else {
			$(greyHeart).removeClass('hidden').show().data('favorite', 'false');
			$(redHeart).addClass('hidden').hide();
		}
	},
	getUserFavorites: function() {
		$.ajax({
      type: 'get',
      url: '/favorites/user_favorites',
      success: function(data){
        console.log(data);
        _.each(data.favorites, function(favorite) {
        	_.each( $('.red-heart'), function(redHeart) {
        		var id = $(redHeart).attr('id');
        		if (parseInt (id) === favorite.variant_id ){
							var greyHeart = $('.grey-heart.heart-'+id);
							$(redHeart).removeClass('hidden').attr('data-favorite-id', favorite.id ).show();
							$(greyHeart).addClass('hidden').hide();
        		}
        	})
        })
      }
    });
	},
	heartToSpinner: function(heart){
		heart.hide();
		var id = heart.attr('id');
		$('.mini-showbox#showbox-'+id).removeClass('hidden');
	},
	cancelLoader: function(data){
		// debugger;
    $(".mini-showbox").addClass("hidden");
	}
}

$(document).ready(function() {
	FAVORITES.addIndividualProductPAgeListener()
});

