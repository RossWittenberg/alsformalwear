var ACCOUNT = {
	addListeners: function() {
		$(".edit-account-details").click(function(event) {
			revealAccountForm();
		});

		$(".submit-user-info").click(function(event) {
			event.preventDefault();

			var id =  $("#user_id").val();
      var first_name =  $("#user_first_name").val();
      var last_name =  $("#user_last_name").val();
      var phone_number =  $("#user_phone_number").val();
      var email =  $("#user_email").val();

      var data = { "user": {
				"first_name": first_name,
				"last_name": last_name,
				"phone_number": phone_number,
				"email": email,
			}};

      if (id.length > 0){
      	var url = "/catalog/users/"+id;
      	var type = "PUT";
      };
			$.ajax({
				url: url,
				type: type,
				dataType: 'json',
				data: data
			})
		  .success(function(data){
		  	if ( data.error_messages !== undefined ){
		  		displayUserErrorIndicators(data);
		  	} else {
					displayAccountSuccessMessage(data);
		  	}
		  })
			.error(function(data){
		  	// add message for bad request
			})
		});

		$(".submit-account-measurements").click(function(event) {
			event.preventDefault();
			console.log('measurements from account submitted')
			var id =  $("#measurement_id").val();
      if (id.length > 0){
      	var url = "/measurements/"+id;
      	var type = "PUT";
      } else {
      	var url = "/measurements";
      	var type = "POST";
      };
      $.ajax({
        type: type,
        url: url,
        data: $('.account-measurements-form').serialize(),
        success: function(data) {
          if ( data.error_messages !== undefined ){
            displayAccountMeasurementErrorIndicators(data);
            console.log(data);
          } else {
            displayAccountMeasurementSuccessMessage(data);
            console.log(data);
          } 
        },
        failure: function(data){
          console.log(data)
        }
      })
		});
	}
}

function displayAccountMeasurementErrorIndicators (data) {
  
  var suitSizeElement =  $("#measurement_suit_size");
  var chestOverarmElement =  $("#measurement_chest_overarm");
  var chestUnderarmElement =  $("#measurement_chest_underarm");
  var pantsWaistElement =  $("#measurement_pants_waist");
  var pantsHipElement =  $("#measurement_pants_hip");
  var pantsOutseamElement =  $("#measurement_pants_outseam");
  var shirtCollarElement =  $("#measurement_shirt_collar");
  var shirtSleeveElement =  $("#measurement_shirt_sleeve");
  var shoeSizeElement =  $("#measurement_shoe_size");
  var heightFeetElement =  $("#measurement_height_feet");
  var heightInchesElement =  $("#measurement_height_inches");
  var weightElement =  $("#measurement_weight");
  var bodyTypeElement =  $("#measurement_body_type");
  var fitPreferenceElement =  $("#measurement_fit_preference");

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
  displayAccountMeasurementErrorMessages(data);
}

function displayAccountMeasurementErrorMessages(data) {
  var messageWrapper = $(".account-measurement-message-wrapper");
  messageWrapper.empty().addClass("alert no-pad").removeClass('success');
  for (var i = data.error_messages.length - 1; i >= 0; i--) {
    var errorMessage = $("<p>").text(data.error_messages[i])
    messageWrapper.append(errorMessage)
  };
  if ( $(window).width() > 768){
    $('body').animate({scrollTop:360}, 1000);
  } else {
    $('body').animate({scrollTop:0}, 1000);
  }
}

function displayAccountMeasurementSuccessMessage(data) {
  var messageWrapper = $(".account-measurement-message-wrapper");
  messageWrapper.empty().removeClass("alert no-pad").addClass('success');
  $('.erroneous-input').removeClass('erroneous-input');
  var successMessage = data.message
  messageWrapper.text(successMessage).addClass('success')
  if ( $(window).width() > 768){
    $('body').animate({scrollTop:360}, 1000);
  } else {
    $('body').animate({scrollTop:0}, 1000);
  }
}

function displayAccountErrorMessages (data) {
	var messageWrapper = $(".message-wrapper");
	messageWrapper.empty();
  for (var i = data.error_messages.length - 1; i >= 0; i--) {
    var errorMessage = $("<p>").addClass("error-message").text(data.error_messages[i])
    messageWrapper.append(errorMessage)
  };
}

function displayAccountSuccessMessage(data){
	var messageWrapper = $(".message-wrapper");
	messageWrapper.empty();
	var successMessage = $("<p>").addClass('success-message').text("Your Account has been successfully updated");
	messageWrapper.append(successMessage);
	concealAccountForm(data);
}

function revealAccountForm () {
	$(".account-form").removeClass('hidden').show();
	$(".account-info-display").hide();
}

function concealAccountForm (data) {
	$(".account-form").addClass('hidden').hide();
	$(".account-info-display").show();  
  $(".user_first_name").text(data.user.first_name);
  $("#user_first_name").val(data.user.first_name);
  $(".user_last_name").text(data.user.last_name);
  $("#user_last_name").val(data.user.last_name);
  $(".user_phone_number").text(data.user.phone_number);
  $("#user_phone_number").val(data.user.phone_number);
  $(".user_email").text(data.user.email);
  $("#user_email").val(data.user.email);
}

function displayUserErrorIndicators (data) {
  var firstNameElement =  $("#user_first_name");
  var lastNameElement =  $("#user_last_name");
  var phoneNumberElement =  $("#user_phone_number");
  var emailElement =  $("#user_email");

	if ( data.error_attributes.includes("first_name")  ){
        firstNameElement.addClass('erroneous-input');
      } else {
        firstNameElement.removeClass('erroneous-input');
      };

	if ( data.error_attributes.includes("last_name") ){
      lastNameElement.addClass('erroneous-input');
    } else {
      lastNameElement.removeClass('erroneous-input');
    };   

	if ( data.error_attributes.includes("phone_number") ){
      phoneNumberElement.addClass('erroneous-input');
    } else {
      phoneNumberElement.removeClass('erroneous-input');
    }; 

	if ( data.error_attributes.includes("email") ){
      emailElement.addClass('erroneous-input');
    } else {
      emailElement.removeClass('erroneous-input');
    };  
	displayAccountErrorMessages(data);
}

function accountDetailsOpen () {
  $('a[href="#accordion-1"]').addClass('active');
  $('div#accordion-1').addClass('open').attr('style', 'display: block;');
  revealAccountForm();
}

$(document).ready(function() {
  accountDetailsOpen();
	if ( $(".account-container").length > 0 || $(".measurements-container").length > 0 ){
		console.log("accounts loaded");
		ACCOUNT.addListeners();
	};
});