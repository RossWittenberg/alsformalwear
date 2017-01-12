var FORMS = {
 
  addListeners: function() {
    $('.appointment-submit-button').click(function(event) {
      event.preventDefault();
      var button = $(this)
      var locationIdParam = $('#appointment_location_id').val();
      var data = $("form.appointment-form").serializeArray();
        if(locationIdParam === ''){
            var key = _.findIndex(data, {name: 'appointment[location_id]'});
            if(key !== -1){
                data[key]['value'] = Cookies.getJSON('neareststore').id;
            }
            console.log(data);
        }
      FORMS.buttonToLoader(button);
      $.ajax({
       type: "PUT",
        url: '/forms/appointment',
        data: data,
        success: function(data) {
          FORMS.cancelLoader();
          if ( data.error_messages !== undefined ){
            FORMS.displayFormErrorIndicators(data);
            console.log(data);
          } else {
            ga( 'send', 'event', 'Appointments', 'New Appointment' );
            FORMS.confirmFormsSuccess(data);
            console.log(data);
          }
        },
        failure: function(data) {
          console.log(data)
        }
      })
    });
    $('.contact-submit-button').click(function(event) {
      event.preventDefault();
      var button = $(this)
      FORMS.buttonToLoader(button);
      $.ajax({
       type: "PUT",
        url: '/forms/contact',
        data: $("form.contact-form").serialize(),
        success: function(data) {
          FORMS.cancelLoader();
          if ( data.error_messages !== undefined ){
            FORMS.displayContactFormErrorIndicators(data);
            console.log(data);
          } else {
            ga('send', 'event', 'Contact', 'New Contact Form', 'Contact');
            FORMS.confirmFormsSuccess(data);
            console.log(data);
          }
        },
        failure: function(data) {
          console.log(data)
        }
      })
    });
    $('.discount-coupon-submit-button').click(function(event) {
      event.preventDefault();
      var button = $(this)
      FORMS.buttonToLoader(button);
      $.ajax({
       type: "PUT",
        url: '/forms/discount',
        data: $("form.discount-form").serialize(),
        success: function(data) {
          FORMS.cancelLoader();
          if ( data.error_messages !== undefined ){
            FORMS.displayFormErrorIndicators(data);
            console.log(data);
          } else {
            FORMS.confirmFormsSuccess(data);
            console.log(data);
          }
        },
        failure: function(data) {
          console.log(data)
        }
      })
    });
    $('.cap-button').click(function(event){
      event.preventDefault();
      var button = $(this)
      FORMS.buttonToLoader(button);
      $.ajax({
       type: "PUT",
        url: '/forms/cap',
        data: $("form.cap-form").serialize(),
        success: function(data) {
          FORMS.cancelLoader();
          if ( data.error_messages !== undefined ){
            FORMS.displayFormErrorIndicators(data);
            console.log(data);
          } else {
            FORMS.confirmFormsSuccess(data);
            console.log(data);
          }
        },
        failure: function(data) {
          console.log(data)
        }
      })
    });


    $('.wedding-discount-form-submit-button').click(function(event){
      event.preventDefault();
      var button = $(this)
      FORMS.buttonToLoader(button);
      $.ajax({
        type: "PUT",
        url: '/forms/wedding-discount',
        data: $('.wedding-discount-form').serialize(),
        success: function(data) {
          FORMS.cancelLoader();
          if ( data.error_messages !== undefined ){
            FORMS.displayFormErrorIndicators(data);
            console.log(data);
          } else {
            ga('send', 'event', 'Landing Pages', 'New Custom Wedding Discount');
            FORMS.confirmFormsSuccess(data);
            console.log(data);
          } 
        },
        failure: function(data){
          console.log(data)
        }
      })
    });


  },
  displayContactFormErrorIndicators: function(data){
    var firstNameElement                 =  $("#contact_first_name");
    var lastNameElement                  =  $("#contact_last_name");
    var contactEmailElement              =  $("#contact_contact_email");
    var contactPhoneElement              =  $("#contact_contact_phone");
    var zipCodeElement                   =  $("#contact_zip_code");
    var locationIdElement                =  $("#contact_location_idSelectBoxIt");
    var subjectElement                   =  $("#contact_subjectSelectBoxIt");
    var contactMethodElement             =  $("#contact_contact_methodSelectBoxIt");
    var contactDateElement               =  $("#contact_contact_date");
    var aptTimeHourElement               =  $("#contact_apt_time__4iSelectBoxIt");
    var aptTimeMinuteElement             =  $("#contact_apt_time__5iSelectBoxIt");
    var contactReasonElement             =  $("#contact_reasonSelectBoxIt");
    var messageElement                   =  $("contact_message")

    if ( data.error_attributes.includes("first_name") ){
      firstNameElement.addClass('erroneous-input');
    } else {
      firstNameElement.removeClass('erroneous-input');
    };  

    if ( data.error_attributes.includes("last_name") ){
      lastNameElement.addClass('erroneous-input');
    } else {
      lastNameElement.removeClass('erroneous-input');
    };

    if ( data.error_attributes.includes("contact_email") ){
      contactEmailElement.addClass('erroneous-input');
    } else {
      contactEmailElement.removeClass('erroneous-input');
    };  

    if ( data.error_attributes.includes("contact_phone") ){
      contactPhoneElement.addClass('erroneous-input');
    } else {
      contactPhoneElement.removeClass('erroneous-input');
    }; 

    if ( data.error_attributes.includes("zip_code") ){
      zipCodeElement.addClass('erroneous-input');
    } else {
      zipCodeElement.removeClass('erroneous-input');
    };  

    if ( data.error_attributes.includes("location_id") ){
      locationIdElement.addClass('erroneous-input');
    } else {
      locationIdElement.removeClass('erroneous-input');
    }; 

    if ( data.error_attributes.includes("subject") ){
      subjectElement.addClass('erroneous-input');
    } else {
      subjectElement.removeClass('erroneous-input');
    }; 
    if ( data.error_attributes.includes("message") ){
      messageElement.addClass('erroneous-input');
    } else {
      messageElement.removeClass('erroneous-input');
    };    
    FORMS.displayFormErrorMessages(data);
  },
  displayFormErrorIndicators: function(data){
    var firstNameElement                 =  $("#appointment_first_name");
    var lastNameElement                  =  $("#appointment_last_name");
    var contactEmailElement              =  $("#appointment_contact_email");
    var contactPhoneElement              =  $("#appointment_contact_phone");
    var zipCodeElement                   =  $("#appointment_zip_code");
    var locationIdElement                =  $("#appointment_location_idSelectBoxIt");
    var contactTimeElement               =  $("#appointment_contact_timeSelectBoxIt");
    var contactMethodElement             =  $("#appointment_contact_methodSelectBoxIt");
    var appointmentDateElement           =  $("#appointment_appointment_date");
    var appointmentAproxdateElement      =  $("#appointment_approximate_event_date");
    var aptTimeHourElement               =  $("#appointment_apt_time__4iSelectBoxIt");
    var aptTimeMinuteElement             =  $("#appointment_apt_time__5iSelectBoxIt");
    var appointmentReasonElement         =  $("#appointment_reasonSelectBoxIt");
    var weddingDateElement               =  $("#wedding_discount_date");
    var weddingEmailElement              =  $("#contact_email");
    var weddingNameElement               =  $("#contact_name");
    var weddingPhoneElement              =  $("#wedding_discount_contact_phone");
    var weddingLocationElement           =  $("#wedding_discount_location_idSelectBoxIt");
    var discountFirstName                =  $("#discount_first_name");
    var discountLastName                 =  $("#discount_last_name");
    var discountEmail                    =  $("#discount_contact_email");
    var discountContactPhone             =  $("#discount_contact_phone");
    var discountZipCode                  =  $("#discount_zip_code");
    var discountLocationId               =  $("#discount_location_idSelectBoxIt");
    var discountDate                     =  $("#discount_date");
    var discountEventType                =  $("#discount_event_typeSelectBoxIt");
    var capOrgElement                    =  $("#cap_orgname");
    var capAddressElement                =  $("#cap_street_address");
    var capCityElement                   =  $("#cap_city");
    var capStateElement                  =  $("#cap_stateSelectBoxIt");
    var capZipElement                    =  $("#cap_zip_code");
    var capTaxElement                    =  $("#cap_tax_id");
    var capFirstElement                  =  $("#cap_first_name");
    var capLastElement                   =  $("#cap_last_name");
    var capPhoneElement                  =  $("#cap_contact_phone");
    var capEmailElement                  =  $("#cap_contact_email");
    var capLocationElement               =  $("#cap_location_idSelectBoxIt");

    if (data.error_attributes.includes("approximate_event_date") ){
      appointmentAproxdateElement.addClass('erroneous-input');
    } else {
      appointmentAproxdateElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("contact_email") ){
      capEmailElement.addClass('erroneous-input');
    } else {
      capEmailElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("location_id") ){
      capLocationElement.addClass('erroneous-input');
    } else {
      capLocationElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("contact_phone") ){
      capPhoneElement.addClass('erroneous-input');
    } else {
      capPhoneElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("last_name") ){
      capLastElement.addClass('erroneous-input');
    } else {
      capLastElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("first_name") ){
      capFirstElement.addClass('erroneous-input');
    } else {
      capFirstElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("tax_id") ){
      capTaxElement.addClass('erroneous-input');
    } else {
      capTaxElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("zip_code") ){
      capZipElement.addClass('erroneous-input');
    } else {
      capZipElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("state") ){
      capStateElement.addClass('erroneous-input');
    } else {
      capStateElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("city") ){
      capCityElement.addClass('erroneous-input');
    } else {
      capCityElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("street_address") ){
      capAddressElement.addClass('erroneous-input');
    } else {
      capAddressElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("orgname") ){
      capOrgElement.addClass('erroneous-input');
    } else {
      capOrgElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("contact_phone") ){
      weddingPhoneElement.addClass('erroneous-input');
    } else {
      weddingPhoneElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("contact_name") ){
      weddingNameElement.addClass('erroneous-input');
    } else {
      weddingNameElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("date") ){
      discountEventType.addClass('erroneous-input');
    } else {
      discountEventType.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("date") ){
      discountDate.addClass('erroneous-input');
    } else {
      discountDate.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("location_id") ){
      discountLocationId.addClass('erroneous-input');
    } else {
      discountLocationId.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("zip_code") ){
      discountZipCode.addClass('erroneous-input');
    } else {
      discountZipCode.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("contact_phone") ){
      discountContactPhone.addClass('erroneous-input');
    } else {
      discountContactPhone.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("contact_email") ){
      discountEmail.addClass('erroneous-input');
    } else {
      discountEmail.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("first_name") ){
      discountFirstName.addClass('erroneous-input');
    } else {
      discountFirstName.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("first_name") ){
      discountLastName.addClass('erroneous-input');
    } else {
      discountLastName.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("date") ){
      weddingDateElement.addClass('erroneous-input');
    } else {
      weddingDateElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("location_id") ){
      weddingLocationElement.addClass('erroneous-input');
    } else {
      weddingLocationElement.removeClass('erroneous-input');
    }

    if (data.error_attributes.includes("contact_email") ){
      weddingEmailElement.addClass('erroneous-input');
    } else {
      weddingEmailElement.removeClass('erroneous-input');
    }

    if ( data.error_attributes.includes("first_name") ){
      firstNameElement.addClass('erroneous-input');
    } else {
      firstNameElement.removeClass('erroneous-input');
    };  

    if ( data.error_attributes.includes("last_name") ){
      lastNameElement.addClass('erroneous-input');
    } else {
      lastNameElement.removeClass('erroneous-input');
    };

    if ( data.error_attributes.includes("contact_email") ){
      contactEmailElement.addClass('erroneous-input');
    } else {
      contactEmailElement.removeClass('erroneous-input');
    };  

    if ( data.error_attributes.includes("contact_phone") ){
      contactPhoneElement.addClass('erroneous-input');
    } else {
      contactPhoneElement.removeClass('erroneous-input');
    }; 

    if ( data.error_attributes.includes("zip_code") ){
      zipCodeElement.addClass('erroneous-input');
    } else {
      zipCodeElement.removeClass('erroneous-input');
    };  

    if ( data.error_attributes.includes("location_id") ){
      locationIdElement.addClass('erroneous-input');
    } else {
      locationIdElement.removeClass('erroneous-input');
    }; 

    if ( data.error_attributes.includes("contact_time") ){
      contactTimeElement.addClass('erroneous-input');
    } else {
      contactTimeElement.removeClass('erroneous-input');
    }; 

    if ( data.error_attributes.includes("contact_method") ){
      contactMethodElement.addClass('erroneous-input');
    } else {
      contactMethodElement.removeClass('erroneous-input');
    }; 

    if ( data.error_attributes.includes("appointment_date") ){
      appointmentDateElement.addClass('erroneous-input');
    } else {
      appointmentDateElement.removeClass('erroneous-input');
    };  

    if ( data.error_attributes.includes("apt_time") ){
      aptTimeHourElement.addClass('erroneous-input');
      aptTimeMinuteElement.addClass('erroneous-input');
    } else {
      aptTimeHourElement.removeClass('erroneous-input');
      aptTimeMinuteElement.removeClass('erroneous-input');
    };  

    if ( data.error_attributes.includes("appointment_reason") ){
      appointmentReasonElement.addClass('erroneous-input');
    } else {
      appointmentReasonElement.removeClass('erroneous-input');
    };  

    FORMS.displayFormErrorMessages(data);
  },
  displayFormErrorMessages: function(data){
    var messageWrapper = $(".message-wrapper");
    messageWrapper.empty().addClass('alert');
    for (var i = data.error_messages.length - 1; i >= 0; i--) {
      var index = data.error_messages.length - i;
      var errorMessage = $("<p>").addClass("error-message index-" + index ).text(data.error_messages[i])
      messageWrapper.append(errorMessage)
    };  
  },
  confirmFormsSuccess: function (data) {
    var messageWrapper = $(".message-wrapper");
    var successModal = $("#successModal");
    var messageText = data.success_message;
    // var messageText = "SUCCESS TEST!"
    $(".successModalMessage").text(messageText);
    successModal.modal('show');
    FORMS.clearErrors();
    messageWrapper.removeClass('alert');
    setTimeout(function(){
      successModal.modal('hide')
    }, 2500);
    $('#aptModal').modal('hide');
    $('#contactModal').modal('hide');
    FORMS.resetInputs();
  },
  clearErrors: function(){
    $(".erroneous-input").removeClass('erroneous-input');
    $(".error-message").empty();
    $(".message-wrapper").empty();
    var messageWrapper = $(".message-wrapper");
    messageWrapper.empty().removeClass('alert');
  },
  clearSuccess: function(){
    $(".message-wrapper").empty();
  },
  buttonToLoader: function(button){
    button.hide();
    $(".showbox").removeClass("hidden")
  },
  cancelLoader: function(){
    $(".showbox").addClass("hidden")
    $(".form-submit-button").show();
  },
  resetInputs: function(){
    console.log("resetting form input values")
    $("input[type=text]").val("");
    $("select").find("option[value='']").attr('selected', 'selected').change();
  }
};
       
$(document).ready(function() {
  console.log("forms js loaded");
  FORMS.addListeners();
});
