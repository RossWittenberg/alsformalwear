var PRINT_LOOK = {
	loaded: function(){
		console.log("print js loaded");
	},
	addListeners: function(){
		var products = $('.product_row');
		for (var i = products.length - 1; i >= 0; i--) {
			var product = products[i];
			var productId = $(product).data("variant-id");
			PRINT_LOOK.fetchVariants(productId); 
		};
		$('.print-btn').click(function(event) {
			PRINT_LOOK.print();
		});

	},
	fetchVariants: function(productId){
		$.ajax({
			url: '/events/variant_look_up',
			type: 'GET',
			dataType: 'json',
			data: {'product_id': productId}
		})
	  .success(function(data){
	  	var variant = data.variant;
	  	PRINT_LOOK.renderVariant(variant);
	  })
		.error(function(data){
	  	// add message for bad request
		})
	},
	renderVariant: function(variant){
  	// DOM elements
  	var productRow = $('#product-'+variant.id);
  	var imageCell = $('#image-'+variant.id);
  	var itemCell = $('#item-'+variant.id);
  	var styleNameCell = $('#style-name-'+variant.id);
  	var colorCell = $('#color-'+variant.id);
  	var styleNumberCell = $('#style-number-'+variant.id);
  	// content
  	var image = $('<img>').attr({
  		src: variant.image_url_small,
  		alt: 'byt look print image'
  	}).css({
  		width: '60px',
  		height: 'auto'
  	});
  	var productCategory = $('<h4>').text(PRINT_LOOK.textTransformProductCategory(variant.product_category_for_print)).css({
  		display: 'inline-block',
  		textTransform: 'capitalize',
  		fontWeight: 600
  	});
  	var designer = $('<h4>').text(variant.designer+":" + String.fromCharCode(160) + String.fromCharCode(160) ).css({
  		display: 'inline-block',
  		textTransform: 'capitalize',
  		fontWeight: 600
  	});
  	var productName = $('<h4>').text(variant.product_name).css({
  		display: 'inline-block',
  		textTransform: 'capitalize',
  		fontWeight: 200,
  		color: '#989898'
  	});
  	var color = $('<h4>').text(variant.child_color).css({
  		display: 'inline-block',
  		textTransform: 'capitalize',
  		fontWeight: 600
  	});
  	var styleNumber = $('<h4>').text('Style No. ' + variant.style_number).css({
  		display: 'inline-block',
  		textTransform: 'capitalize',
  		fontWeight: 600
  	});
  	// append content to DOM
  	$(imageCell).append(image);
  	$(itemCell).append(productCategory);
  	$(styleNameCell).append(designer).append(productName);
  	$(colorCell).append(color);
  	$(styleNumberCell).append(styleNumber);
  	$(productRow).attr("data-complete", "true");
	},
	textTransformProductCategory: function(category){
    switch(category){
        case 'Tuxedos':
            category = 'tuxedo';
            break;
        case 'Vests or Cummerbunds':
            category = 'vest / cummerbund';
            break;
        case 'Shirts':
            category = 'shirt';
            break;
        case 'Ties':
            category = 'tie';
            break;
    }
    return category;
	},
	print: function(){
		window.print();
	}
}

$(document).ready(function() {
	PRINT_LOOK.loaded();
	PRINT_LOOK.addListeners();
})


