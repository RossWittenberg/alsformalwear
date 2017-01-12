var measureit = {
	addListeners: function() {
		$(".submit-measurements").click(function(event) {
			event.preventDefault();
			var id =  $("#measurement_id").val();
      var suit_size =  $("#measurement_suit_size").val();
      var chest_overarm =  $("#measurement_chest_overarm").val();
      var chest_underarm =  $("#measurement_chest_underarm").val();
      var pants_waist =  $("#measurement_pants_waist").val();
      var pants_hip =  $("#measurement_pants_hip").val();
      var pants_outseam =  $("#measurement_pants_outseam").val();
      var shirt_collar =  $("#measurement_shirt_collar").val();
      var shirt_sleeve =  $("#measurement_shirt_sleeve").val();
      var shoe_size =  $("#measurement_shoe_size").val();
      var height_feet =  $("#measurement_height_feet").val();
      var height_inches =  $("#measurement_height_inches").val();
      var weight =  $("#measurement_weight").val();
      var body_type =  $("#bodyType").val();
      var fit_preference =  $("#measurement_fit_preference").val();
      var data = { "measurement": {
        "suit_size": suit_size,
        "chest_overarm": chest_overarm,
        "chest_underarm": chest_underarm,
        "pants_waist": pants_waist,
        "pants_hip": pants_hip,
        "pants_outseam": pants_outseam,
        "shirt_collar": shirt_collar,
        "shirt_sleeve": shirt_sleeve,
        "shoe_size": shoe_size,
        "height_feet": height_feet,
        "height_inches": height_inches,
        "weight": weight,
        "body_type": body_type,
        "fit_preference": fit_preference
      }};
      if (id.length > 0){
      	var url = "/measurements/"+id;
      	var type = "PUT";
      } else {
      	var url = "/measurements";
      	var type = "POST";
      };
			$.ajax({
				context: this,
				url: url,
				type: type,
				dataType: 'json',
				data: data
			})
		  .success(function(data, json){
		  	var element = $(this)
		  	if ( data.error_messages !== undefined ){
          displayMeasurementErrorMessages(data);
		  	} else {
					confirmMeasurementSuccess(data, element);
		  	}
		  })
			.error(function(data){
		  	// add message for bad request
			})
		});

    $('.set-measurements').click(function(event){
      event.preventDefault();
      var dataKey = $(this).prev().prev().find('input, select').attr('name');
      var data = {};
      data[dataKey] =  $(this).prev().prev().find('input, select').val();
      $.ajax({
        context: this,
        url: '/measurements/validate',
        type: 'PUT',
        dataType: 'json',
        data: data
      })
      .success(function(data, json){
        var element = $(this)
        if ( data.error_messages !== undefined ){
          displayMeasurementValidationErrorIndicators(data, element);
        } else {
          successfulValidation(data, element)
        }
      })
      .error(function(data){
        // add message for bad request
      })
      
    });

    $('.oot-set-measurements').click(function(event){
      event.preventDefault();
      var name  = $(this).prev().prev().prev().attr('name') || $(this).prev().prev().prev().prev().attr('name')
      var dataKey = "measurement["+name+"]"
      var data = {};
      data[dataKey] = $(this).prev().prev().prev().val();
      data["oot"] = true;
      $.ajax({
        context: this,
        url: '/measurements/validate',
        type: 'PUT',
        dataType: 'json',
        data: data
      })
      .success(function(data, json){
        var element = $(this)
        if ( data.error_messages !== undefined ){
          displayMeasurementValidationErrorIndicators(data, element);
        } else {
          successfulValidation(data, element)
        }
      })
      .error(function(data){
        // add message for bad request
      })
    });

    $('.oot-submit').click(function(event){
      event.preventDefault();
      $(this).hide();
      $('.showbox').removeClass('hidden').show();
      $.ajax({
        type: "PUT",
        url: '/measurements/out-of-town',
        data: $('.oot-form').serialize(),
        success: function(data) {
          $('.oot-submit').show();
          $('.showbox').addClass('hidden').hide();
          if ( data.error_messages !== undefined ){
            displayOotmeasurementErrorIndicators(data);
            console.log(data);
          } else {
            displayOotmeasurementSuccess(data);
            console.log(data);
          } 
        },
        failure: function(data){
          console.log(data)
        }
      })
    });
	},
	onReady: function() {

		var selectBox = $("select.measurement-form-field");

		selectBox.selectBoxIt({
			autoWidth: false
		});

		selectBox.on('change', function(){
			console.log($(this).val());
			switch($(this).val()) {
				case 'Modern':
					$(this).parentsUntil('div.panel-body').find('div.measure-img img').attr('class', 'modern')
					break;
				case 'Classic':
					$(this).parentsUntil('div.panel-body').find('div.measure-img img').attr('class', 'classic')
					break;
				case 'Slim':
					$(this).parentsUntil('div.panel-body').find('div.measure-img img').attr('class', 'slim')
					break;
				case 'Slender':
					$(this).parentsUntil('div.panel-body').find('div.measure-img img').attr('class', 'slender')
					break;
				case 'Muscular':
					$(this).parentsUntil('div.panel-body').find('div.measure-img img').attr('class', 'muscular')
					break;
				case 'Normal':
					$(this).parentsUntil('div.panel-body').find('div.measure-img img').attr('class', 'normal')
					break;
				case 'Hefty':
					$(this).parentsUntil('div.panel-body').find('div.measure-img img').attr('class', 'hefty')
					break;
			}
		});

		$('a[href="#measurements-scroll"]').click(function(){
			$('body').animate({scrollTop:800}, 1000);
		});

		function close_accordion_section() {
			$('.accordion-measure .accordion-section-title').removeClass('active');
			$('.accordion-measure .accordion-section-content').slideUp(300).removeClass('open');
		}

		$('.accordion-section-title').click(function(e) {
			// Grab current anchor value
			var currentAttrValue = $(this).attr('href');

			if($(e.target).is('.active')) {
				close_accordion_section();
			} else {
				close_accordion_section();

				// Add active class to section title
				$(this).addClass('active');
				// Open up the hidden content panel
				$('.accordion-measure ' + currentAttrValue).slideDown(300).addClass('open'); 
			}

			e.preventDefault();
		});
	}
}

function resetButton(element, originalButtonText, oot){
  if ( oot === true ) {
    var input = $(element).prev().prev().prev();
  } else {
    var input = $(element).prev().prev().find(".measurement-form-field");
  }
  $(input).css('border', '2px solid #000');
  $(element).css({
    border: '2px solid #000',
    backgroundColor: '#000'
  }).val(originalButtonText);
}
function successfulValidation(data, element){
  var messageWrapper = element.prev();
  messageWrapper.empty().removeClass('alert').addClass('success-message');
  if ( data.oot !== undefined ) {
    var elementInput = element.prev().prev().prev();
    var oot = true;
  } else {
    var elementInput = element.prev().prev().find('.measurement-form-field');
    var oot = false;
  }
  $(elementInput).css('border', '2px solid #2ecc71').removeClass('alert').removeClass('erroneous-input');
  var originalButtonText = element.val();
  var check_mark = $(element).closest('.panel-default').find('.confirmed');
  var currentPanel = $(element).closest("div.panel.panel-default");
  var nextPanel = currentPanel.next();

  $(element).css({
    border: '2px solid #2ecc71',
    backgroundColor: '#2ecc71'
  }).val('set!');

  setTimeout(function(){
    if ($(nextPanel).hasClass('hidden')) {
      $(nextPanel).removeClass('hidden');
      $(nextPanel).find(".panel-title a").click();
    }
    else {
    $(nextPanel).find(".panel-title a").click();
    }
  }, 800);
  
  check_mark.addClass('isConfirmed');
  
  setTimeout(function(){
    resetButton(element, originalButtonText, oot);
  }, 1500);
}
function resetChecksAndErrors(){
  $('.isConfirmed').removeClass('isConfirmed');
  var messageWrapper = $(".oot-message-wrapper");
  messageWrapper.removeClass('alert').empty();
}

function displayValidationErrorMessages (data, element) {
  var messageWrapper = element.prev();
  messageWrapper.empty();
  messageWrapper.text(data.error_messages).addClass('alert').removeClass('success');
}



function displayOotmeasurementErrorIndicators (data) {  
  var messageWrapper = $(".message-wrapper");
  messageWrapper.addClass('alert');
  displayOotErrorMessages(data);
}

function displayOotmeasurementSuccess (data) {
  var messageWrapper = $(".oot-message-wrapper");

  var successModal = $("#successModal");
  var messageText = data.success_message;

  resetChecksAndErrors();
  $(".successModalMessage").text(messageText);
  successModal.modal('show');
  messageWrapper.removeClass('alert').empty();
  setTimeout(function(){
    successModal.modal('hide')
  }, 2500);
}

function displayOotErrorMessages(data) {
  var messageWrapper = $(".oot-message-wrapper");
  messageWrapper.empty().addClass("alert no-pad").removeClass('success');
  for (var i = data.error_messages.length - 1; i >= 0; i--) {
    var errorMessage = $("<p>").text(data.error_messages[i])
    messageWrapper.append(errorMessage)
  };
  if ( $(window).width() > 768){
    $('body').animate({scrollTop:400}, 1000);
  } else {
    $('body').animate({scrollTop:0}, 1000);
  }
}

function displayMeasurementErrorMessages(data) {
  var messageWrapper = $(".measurement-message-wrapper");
  messageWrapper.empty().addClass("alert no-pad").removeClass('success');
  for (var i = data.error_messages.length - 1; i >= 0; i--) {
    var errorMessage = $("<p>").text(data.error_messages[i])
    messageWrapper.append(errorMessage)
  };
  if ( $(window).width() > 768){
    $('body').animate({scrollTop:200}, 1000);
  } else {
    $('body').animate({scrollTop:0}, 1000);
  }
}


function displayMeasurementValidationErrorIndicators (data, element) {
  
  var suitSizeElement =  $("#measurement_suit_size, #suit_size");
  var chestOverarmElement =  $("#measurement_chest_overarm, #chest_overarm");
  var chestUnderarmElement =  $("#measurement_chest_underarm, #chest_underarm");
  var pantsWaistElement =  $("#measurement_pants_waist, #pants_waist");
  var pantsHipElement =  $("#measurement_pants_hip, #pants_hip");
  var pantsOutseamElement =  $("#measurement_pants_outseam, #pants_outseam");
  var shirtCollarElement =  $("#measurement_shirt_collar, #shirt_collar");
  var shirtSleeveElement =  $("#measurement_shirt_sleeve, #shirt_sleeve");
  var shoeSizeElement =  $("#measurement_shoe_size, #shoe_size");
  var heightFeetElement =  $("#measurement_height_feet, #height_feet");
  var heightInchesElement =  $("#measurement_height_inches, #height_inches");
  var weightElement =  $("#measurement_weight, #weight");
  var bodyTypeElement =  $("#measurement_body_type, #body_type");
  var fitPreferenceElement =  $("#measurement_fit_preference, #fit_preference");

	if ( data.error_attributes.includes("suit_size")  ){
        suitSizeElement.addClass('erroneous-input');
      } else {
        suitSizeElement.removeClass('erroneous-input');
      };

	if ( data.error_attributes.includes("chest_overarm") ){
      chestOverarmElement.addClass('erroneous-input');
    } else {
      chestOverarmElement.removeClass('erroneous-input');
    };   

	if ( data.error_attributes.includes("chest_underarm") ){
      chestUnderarmElement.addClass('erroneous-input');
    } else {
      chestUnderarmElement.removeClass('erroneous-input');
    }; 

	if ( data.error_attributes.includes("pants_waist") ){
      pantsWaistElement.addClass('erroneous-input');
    } else {
      pantsWaistElement.removeClass('erroneous-input');
    }; 

	if ( data.error_attributes.includes("pants_hip") ){
      pantsHipElement.addClass('erroneous-input');
    } else {
      pantsHipElement.removeClass('erroneous-input');
    };   

	if ( data.error_attributes.includes("pants_outseam") ){
      pantsOutseamElement.addClass('erroneous-input');
    } else {
      pantsOutseamElement.removeClass('erroneous-input');
    };  
  displayValidationErrorMessages(data, element);
}

function confirmMeasurementSuccess (data, element) {
  var messageWrapper = $(".measurement-message-wrapper");
  messageWrapper.empty();
  var successMessage = data.message
  messageWrapper.append(successMessage).removeClass('error-message').addClass('success');
  if ( $(window).width() > 768){
    $('body').animate({scrollTop:200}, 1000);
  } else {
    $('body').animate({scrollTop:0}, 1000);
  }
};

$(document).ready(function(){
	measureit.onReady();
	measureit.addListeners();
});
