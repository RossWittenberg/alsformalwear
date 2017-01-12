$(document).ready(function(){
  if(GetURLParameter("event") > 0){
    var eventId = GetURLParameter("event");
    openEventTab(eventId);
  }; 
  $('.placeholder-slide').hide();
  $('.moving-placeholder').each(
      function(){
        $(this).prev().append($(this).attr('placeholder'));
        $(this).data('holder',$(this).attr('placeholder'));
        $(this).focusin(function(){
            $(this).attr('placeholder','');
        });
        $(this).focusout(function(){
            $(this).attr('placeholder',$(this).data('holder'));
        });
        if($(this).val().length > 0) {
          $(this).prev().fadeIn(125);
        }
    });
  $('.moving-placeholder').focus(function(){
    $(this).prev().fadeIn(125);
  });
  $('.moving-placeholder').blur(function(){
    if($(this).val().length == 0) {
      $(this).prev().hide();
    }
  });
  $('.moving-placeholder').keydown(function(){
    $(this).focus();
  });


  $('input#appointment_contact_phone, .phone-number').on('keyup', function(){
  this.value = this.value
      .match(/\d*/g).join('')
      .match(/(\d{0,3})(\d{0,3})(\d{0,4})/).slice(1).join('-')
      .replace(/-*$/g, '');  
  });

  $('.fed-tax-id').on('keyup', function(){
  this.value = this.value
      .match(/\d*/g).join('')
      .match(/(\d{0,2})(\d{0,7})/).slice(1).join('-')
      .replace(/-*$/g, '');  
  });

  $(".school-group-sales-submit-button").click(function(event) {
    var button = $(this)
    event.preventDefault();  
    console.log("submitting school group sales form via ajax")
    var schoolGroupSalesForm = $(this).parents('form:first');

    submitSchoolGroupSalesForm(schoolGroupSalesForm, button);/* Act on the event */
  });

  $(".occasion-submit-button").click(function(event) {
    var button = $(this)
    event.preventDefault();  
    console.log("submitting occasion form via ajax")
    var occasionForm = $(this).parents('form:first');
    submitOccasionForm(occasionForm, button);
  });

  $('.social-event-text').hide();
  $('.als-rep-text').hide();
  $('.education-fund-text').hide();

  $('.group-offers-form-wrapper h3.form-dropdown').click(function(){
    var topOfForm = $(this).prev('a');
    if ( $(this).hasClass('open') ){
      $('h3.form-dropdown').next().hide().toggleClass('closed').toggleClass('open');
      $(this).next().hide();
      $(this).addClass('closed');
      $(this).removeClass('open');
    } else {
      $('h3.form-dropdown').next().hide().toggleClass('closed').toggleClass('open');
      $(this).next().slideDown(300);
      $(this).addClass('open');
      $(this).removeClass('closed');
    }
    clearErrors();
    BUTTONS.scrollToTopOfForm( topOfForm );
  });

  $('.wedding-discount-open').addClass('open').next().slideDown(300);

  $('select#event_id').on('change', function(){
    if ( $(this).val().length > 0 ) {
      $('input#event_event_name').val('').addClass('disabled').attr("disabled", true);
      $('input#event_date').val('').addClass('disabled').attr("disabled", true);
      $('input#prom-rep-date-picker').val('').addClass('disabled').attr("disabled", true);
    } else {
      $('input#event_event_name').val('').removeClass('disabled').attr("disabled", false);
      $('input#event_date').val('').removeClass('disabled').attr("disabled", false);
      $('input#prom-rep-date-picker').val('').removeClass('disabled').attr("disabled", false);
    }
  });

  function nameFields(){
    var firstName = $('input.first_name').val();
    var lastName = $('input.last_name').val();
    var email = $('input.email').val();

    var brideFirstName = $('input.bride_first_name');
    var brideLastName = $('input.bride_last_name');
    var brideEmail = $('input.bride_email');

    var groomFirstName = $('input.groom_first_name');
    var groomLastName = $('input.groom_last_name');
    var groomEmail = $('input.groom_email');


    if($(this).val() === 'Bride') {
      brideFirstName.attr('value', firstName);
      brideLastName.attr('value', lastName);
      brideEmail.attr('value', email);
      clearGroom();
    } else if($(this).val() === 'Groom') {
      groomFirstName.attr('value', firstName);
      groomLastName.attr('value', lastName);
      groomEmail.attr('value', email);
      clearBride();
    } else if($(this).val() === 'I AM THE:') {
      console.log('Not Valid For Submission');
      clearBoth();
    } else {
      console.log('Third Party User');
      clearBoth();
    }

    function clearGroom() {
      groomFirstName.attr('value', '');
      groomLastName.attr('value', '');
      groomEmail.attr('value', '');
    }
    function clearBride() {
      brideFirstName.attr('value', '');
      brideLastName.attr('value', '');
      brideEmail.attr('value', '');
    }
    function clearBoth() {
      brideFirstName.attr('value', '');
      brideLastName.attr('value', '');
      brideEmail.attr('value', '');
      groomFirstName.attr('value', '');
      groomLastName.attr('value', '');
      groomEmail.attr('value', '');
    }
  }

  $('.role.measurement-form-field').on('change', nameFields);

  var discTotal = 40;
  $('.calc').on('change', function(){
    var bm = parseInt($('#best_man').val());
    var gm = parseInt($('#groomsmen').val());
    var fotb = parseInt($('#fot_bride').val());
    var fotg = parseInt($('#fot_groom').val());
    var rb = parseInt($('#ringbearer').val());
    var us = parseInt($('#ushers').val());
    var at = parseInt($('#attendants').val());

    if( !isNaN(bm) ){ discTotal = discTotal + (bm*40) }
    if( !isNaN(gm) ){ discTotal = discTotal + (gm*40) }
    if( !isNaN(fotb) ){ discTotal = discTotal + (fotb*40) }
    if( !isNaN(fotg) ){ discTotal = discTotal + (fotg*40) }
    if( !isNaN(rb) ){ discTotal = discTotal + (rb*40) }
    if( !isNaN(us) ){ discTotal = discTotal + (us*40) }
    if( !isNaN(at) ){ discTotal = discTotal + (at*40) }
    
    if(discTotal !== 40){
      $('.discount-total span').append('<p>').text('$' + discTotal + '.00');
      $('.wedding-discTotal').val(discTotal);
    } else if (discTotal === 40) {
      $('.discount-total span').append('<p>').text('$0.00');
    }
    discTotal = 40;
  });

  var url = window.location.href.toString();
  console.log(url);
  if( url.indexOf('prom/#rep-form') > -1 ) {
    $('a#rep-form').next().next().slideDown();
    $('a#rep-form').next().toggleClass('closed').toggleClass('open');
  }
  else if ( url.indexOf('prom/#school-fund') > -1 ) {
    $('a#school-fund').next().next().slideDown();
    $('a#school-fund').next().toggleClass('closed').toggleClass('open');
  }
  else if ( url.indexOf('prom/#school-group') > -1 ) {
    $('a#school-group').next().next().slideDown();
    $('a#school-group').next().toggleClass('closed').toggleClass('open');
  }
  else if ( url.indexOf('social-event/#social-fund') > -1 ) {
    $('a#social-fund').next().next().slideDown();
    $('a#social-fund').next().toggleClass('closed').toggleClass('open');
  }
  else if ( url.indexOf('wedding/#wedding-sweepstakes') > -1 ) {
    $('a#wedding-sweepstakes').next().next().slideDown();
    $('a#wedding-sweepstakes').next().toggleClass('closed').toggleClass('open');
  }
  else if ( url.indexOf('wedding/#wedding-discount') > -1 ) {
    $('a#wedding-discount').next().next().slideDown();
    $('a#wedding-discount').next().toggleClass('closed').toggleClass('open');
  }
  else if ( url.indexOf('prom/#work-study') > -1 ) {
    $('a#work-study').next().next().slideDown();
    $('a#work-study').next().toggleClass('closed').toggleClass('open');
  }

  $("select.event_juniors").on('change', function(){
    if ( $(this).val() === 'true' ) {
      $('#event_number_juniors').removeClass('hidden').show();
    } else {
      $('#event_number_juniors').addClass('hidden').hide();
    }
  });
  
  var groupOffer = $('a#group-offers');
  var socialFundTop = $('a#social-fund');
  var weddingButton = $('.button-primary.wedding');
  var socialEventButton = $('.button-primary.social-event');

  weddingButton.on('click', function(){
    var scrollAmmount = socialFundTop.offset().top - 110;
    $('body').animate({ scrollTop: scrollAmmount }, "slow");
  });

  socialEventButton.on('click', function(){
    var scrollAmmount = socialFundTop.offset().top - 550;
    $('body').animate({ scrollTop: scrollAmmount }, "slow");
  });
});

function submitSchoolGroupSalesForm(form, button) {
  var data = $(form).serialize();
  buttonToLoader(button)
  $.ajax({
    context: this,
    url: '/forms/school_group_sales',
    type: 'PUT',
    dataType: 'json',
    data: data,
    success: function(data, json) {
      cancelLoader();
      var element = $(this)
      if ( data.error_messages !== undefined ){
        displayOccasionErrorIndicators(data);
      } else {
        ga('send', 'event', 'Landing Pages', 'New School Group Sales', 'Schools');
        confirmOccasionSuccess(data, element);
      }
    },
    error: function(data) {
    }
  })
}

function submitOccasionForm(occasionForm, button) {
  var data = $(occasionForm).serialize();
  var id = $(occasionForm).find("#event_id").val() || "";
  if (id.length > 0){
    var url = "/events/update_with_group_code/"+id;
    var type = "PUT";
  } else {
    var url = "/events/create_with_group_code";
    var type = "POST";
  };
  buttonToLoader(button)
  $.ajax({
    context: this,
    url: url,
    type: type,
    dataType: 'json',
    data: data,
    success: function(data, json) {
      cancelLoader();
      var element = $(this)
      if ( data.error_messages !== undefined ){
        displayOccasionErrorIndicators(data);
      } else {
        if (data.form_type === "school fundraiser"){
          ga('send', 'event', 'Landing Pages', 'New School Fundraiser', 'Schools');
          console.log("shchool fundraiser form was submitted");
        }else if (data.form_type === "prom rep"){
          ga('send', 'event', 'Landing Pages', 'New School Rep', 'Schools');
          console.log("prom rep form was submitted");
        }else if (data.form_type === "social event"){
          ga('send', 'event', 'Landing Pages', 'New Social Event Fundraising', 'Social');
          console.log("social event form was submitted");
        }else if (data.form_type === "wedding sweepstakes"){
          ga('send', 'event', 'Landing Pages', 'New Wedding Sweepstakes', 'Weddings');
          console.log("wedding sweepstakes form was submitted");
        } 
        confirmOccasionSuccess(data, element);
      }
    },
    error: function(data) {
    }
  })
}

function displayOccasionErrorIndicators(data) {

  if (data.form_type === "prom rep"){
    var orgNameElement =  $(".prom-orgname");
  } else if (data.form_type === "school group sales"){
    var orgNameElement =  $(".school-group-sales-orgname");
  } else {
    var orgNameElement =  $("#event_orgname");
  }

  if (data.form_type === "prom rep"){
    var streetAddressElement =  $(".prom-street-address");
  } else if (data.form_type === "school group sales"){
    var streetAddressElement =  $(".school-group-sales-street-address");
  } else {
    var streetAddressElement =  $("#event_street_address");
  }

  if (data.form_type === "prom rep"){
    var cityElement =  $(".prom-city");
  } else if (data.form_type === "school group sales"){
    var cityElement =  $(".school-group-sales-city");
  } else {
    var cityElement =  $("#event_city");
  }  

  if (data.form_type === "prom rep"){
    var stateElement =  $("#event_stateSelectBoxIt.prom-state");
  } else if (data.form_type === "school group sales"){
    var stateElement =  $(".school-group-sales-state");
  } else {
    var stateElement =  $("#event_stateSelectBoxIt");
  }  

  if (data.form_type === "prom rep"){
    var zipCodeElement =  $(".prom-zip-code");
  } else if (data.form_type === "school group sales"){
    var zipCodeElement =  $(".school-group-sales-zip-code");
  } else {
    var zipCodeElement =  $("#event_zip_code");
  }

  if (data.form_type === "prom rep"){
    var locationIdElement =  $(".prom-location-id");
  } else if (data.form_type === "school group sales"){
    var locationIdElement =  $(".school-group-sales-location-id");
  } else {
    var locationIdElement =  $("#event_location_idSelectBoxIt");
  } 

  if (data.form_type === "prom rep"){
    var firstNameElement =  $(".prom-first-name");
  } else if (data.form_type === "school group sales"){
    var firstNameElement =  $(".school-group-sales-first-name");
  } else {
    var firstNameElement =  $("#event_first_name");
  }

  if (data.form_type === "prom rep"){
    var lastNameElement =  $(".prom-last-name");
  } else if (data.form_type === "school group sales"){
    var lastNameElement =  $(".school-group-sales-last-name");
  } else {
    var lastNameElement =  $("#event_last_name");
  }

  if (data.form_type === "prom rep"){
    var dateElement =  $(".prom-date");
  } else if (data.form_type === "school group sales"){
    var dateElement =  $(".school-group-sales-date");
  } else {
    var dateElement =  $("#event_date");
  } 

  var taxIdElement =  $("#event_tax_id");
  var contactEmailElement        =  $(".event_contact_email,.school-group-sales-contact-email");
  var referralNameElement        =  $("#event_referral_name");
  var eventNameElement          =  $("#event_event_name");
  var eventTypeElement =  $("#event_event_type");
  var roleElement =  $("#event_roleSelectBoxIt");
  var contactTitleElement =  $("#event_contact_title");
  var contactPhoneElement =  $("#event_contact_phone,.school-group-sales-contanct-phone");
  var groomFirstNameElement = $("#event_groom_first_name");
  var groomLastNameElement = $("#event_groom_last_name");
  var groomEmailElement = $("#event_groom_email");
  var brideFirstNameElement = $("#event_bride_first_name");
  var brideLastNameElement = $("#event_bride_last_name");
  var brideEmailElement = $("#event_bride_email");

  var schoolCityElement = $("#event_school_city");
  var schoolStateElement = $("#event_school_stateSelectBoxIt");
  var schoolStreetAddressElement = $("#event_school_street_address");
  var schoolZipCodeElement = $("#event_school_zip_code");

  var juniorsElement = $("#event_juniorsSelectBoxIt");
  var blackTieElement = $("#event_black_tieSelectBoxIt");
  var schoolYearElement = $("#event_school_yearSelectBoxIt");

  var budgetElement          = $(".school-group-sales-budget");
  var numberUniformsElement  = $(".school-group-sales-number-uniform");
  var deadlineElement        = $(".school-group-sales-deadline");
  var schoolDistrictElement  = $(".school-group-sales-school-district");
  var schoolTypeElement      = $(".school-group-sales-school-type");
  var schoolLevelElement     = $(".school-group-sales-school-level");
  var teacherNameElement     = $(".school-group-sales-teacher-name");
  var groupTypeElement       = $(".school-group-sales-group-type");
  var uniformTypeElement     = $(".school-group-sales-uniform-type");

  var promRepPhoneElement    = $("#event_contact_phone")


  if ( data.error_attributes.includes("contact_phone")  ){
    promRepPhoneElement.addClass('erroneous-input');
  } else {
    promRepPhoneElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("contact_email")  ){
    contactEmailElement.addClass('erroneous-input');
  } else {
    contactEmailElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("budget")  ){
    budgetElement.addClass('erroneous-input');
  } else {
    budgetElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("number_uniforms")  ){
    numberUniformsElement.addClass('erroneous-input');
  } else {
    numberUniformsElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("deadline")  ){
    deadlineElement.addClass('erroneous-input');
  } else {
    deadlineElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("school_district")  ){
    schoolDistrictElement.addClass('erroneous-input');
  } else {
    schoolDistrictElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("school_type")  ){
    schoolTypeElement.addClass('erroneous-input');
  } else {
    schoolTypeElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("school_level")  ){
    schoolLevelElement.addClass('erroneous-input');
  } else {
    schoolLevelElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("teacher_name")  ){
    teacherNameElement.addClass('erroneous-input');
  } else {
    teacherNameElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("group_type")  ){
    groupTypeElement.addClass('erroneous-input');
  } else {
    groupTypeElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("uniform_type")  ){
    uniformTypeElement.addClass('erroneous-input');
  } else {
    uniformTypeElement.removeClass('erroneous-input');
  };
  if ( data.error_attributes.includes("orgname")  ){
    orgNameElement.addClass('erroneous-input');
  } else {
    orgNameElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("street_address") ){
    streetAddressElement.addClass('erroneous-input');
  } else {
    streetAddressElement.removeClass('erroneous-input');
  };   

  if ( data.error_attributes.includes("city") ){
    cityElement.addClass('erroneous-input');
  } else {
    cityElement.removeClass('erroneous-input');
  }; 

  if ( data.error_attributes.includes("state") ){
    stateElement.addClass('erroneous-input');
  } else {
    stateElement.removeClass('erroneous-input');
  }; 

  if ( data.error_attributes.includes("zip_code") ){
    zipCodeElement.addClass('erroneous-input');
  } else {
    zipCodeElement.removeClass('erroneous-input');
  }; 

  if ( data.error_attributes.includes("tax_id") ){
    taxIdElement.addClass('erroneous-input');
  } else {
    taxIdElement.removeClass('erroneous-input');
  };   

  if ( data.error_attributes.includes("referral_name") ){
    referralNameElement.addClass('erroneous-input');
  } else {
    referralNameElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("event_name") ){
    eventNameElement.addClass('erroneous-input');
  } else {
    eventNameElement.removeClass('erroneous-input');
  };

  if ( data.error_attributes.includes("event_type") ){
    eventTypeElement.addClass('erroneous-input');
  } else {
    eventTypeElement.removeClass('erroneous-input');
  };  

  if ( data.error_attributes.includes("date") ){
    dateElement.addClass('erroneous-input');
  } else {
    dateElement.removeClass('erroneous-input');
  };  

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

  if ( data.error_attributes.includes("contact_title") ){
    contactTitleElement.addClass('erroneous-input');
  } else {
    contactTitleElement.removeClass('erroneous-input');
  };  

  if ( data.error_attributes.includes("contact_phone") ){
    contactPhoneElement.addClass('erroneous-input');
  } else {
    contactPhoneElement.removeClass('erroneous-input');
  };  

  if ( data.error_attributes.includes("location_id") ){
    locationIdElement.addClass('erroneous-input');
  } else {
    locationIdElement.removeClass('erroneous-input');
  }; 

  if ( data.error_attributes.includes("groom_first_name") ){
    groomFirstNameElement.addClass('erroneous-input');
  } else {
    groomFirstNameElement.removeClass('erroneous-input');
  };  

  if ( data.error_attributes.includes("groom_last_name") ){
    groomLastNameElement.addClass('erroneous-input');
  } else {
    groomLastNameElement.removeClass('erroneous-input');
  };      

  if ( data.error_attributes.includes("groom_email") ){
    groomEmailElement.addClass('erroneous-input');
  } else {
    groomEmailElement.removeClass('erroneous-input');
  };        
  
  if ( data.error_attributes.includes("bride_first_name") ){
    brideFirstNameElement.addClass('erroneous-input');
  } else {
    brideFirstNameElement.removeClass('erroneous-input');
  };  

  if ( data.error_attributes.includes("bride_last_name") ){
    brideLastNameElement.addClass('erroneous-input');
  } else {
    brideLastNameElement.removeClass('erroneous-input');
  };  
  
  if ( data.error_attributes.includes("bride_email") ){
    brideEmailElement.addClass('erroneous-input');
  } else {
    brideEmailElement.removeClass('erroneous-input');
  };  
  
  if ( data.error_attributes.includes("role") ){
   roleElement.addClass('erroneous-input');
  } else {
   roleElement.removeClass('erroneous-input');
  };            
  
  if ( data.error_attributes.includes("juniors") ){
   juniorsElement.addClass('erroneous-input');
  } else {
   juniorsElement.removeClass('erroneous-input');
  };   

  if ( data.error_attributes.includes("black_tie") ){
   blackTieElement.addClass('erroneous-input');
  } else {
   blackTieElement.removeClass('erroneous-input');
  }; 

  if ( data.error_attributes.includes("school_year") ){
   schoolYearElement.addClass('erroneous-input');
  } else {
   schoolYearElement.removeClass('erroneous-input');
  }; 

  if ( data.error_attributes.includes("school_city") ){
   schoolCityElement.addClass('erroneous-input');
  } else {
   schoolCityElement.removeClass('erroneous-input');
  }; 

  if ( data.error_attributes.includes("school_state") ){
   schoolStateElement.addClass('erroneous-input');
  } else {
   schoolStateElement.removeClass('erroneous-input');
  }; 

  if ( data.error_attributes.includes("school_zip_code") ){
   schoolZipCodeElement.addClass('erroneous-input');
  } else {
   schoolZipCodeElement.removeClass('erroneous-input');
  }; 

  if ( data.error_attributes.includes("school_street_address") ){
   schoolStreetAddressElement.addClass('erroneous-input');
  } else {
   schoolStreetAddressElement.removeClass('erroneous-input');
  };                    
    
  displayOccasionErrorMessages(data);
}

function displayOccasionErrorMessages(data) {
  var messageWrapper = $(".message-wrapper");
  messageWrapper.empty().addClass('alert');
  for (var i = data.error_messages.length - 1; i >= 0; i--) {
    var index = data.error_messages.length - i;
    var errorMessage = $("<p>").addClass("error-message index-" + index ).text(data.error_messages[i])
    messageWrapper.append(errorMessage)
  };  
  scrollToMessage(data);
}

function confirmOccasionSuccess(data, element) {  
  
  var messageWrapper = $(".message-wrapper");
  clearErrors();
  if ( data.success_message.length > 0 ){
    var messageText = data.success_message;
  }
  var successModal = $("#occassionSuccessModal");
  $(".successModalMessage").text(messageText);
  successModal.modal('show');
  messageWrapper.removeClass('alert');
  $('#occasion-success-button').attr('href', data.redirect);
  setTimeout(function(){
    successModal.modal('hide');
    closeOpenedAccordians();
  }, 5500);
  resetFormInputs();
  scrollToMessage(data);
}

function clearErrors() {
  $(".erroneous-input").removeClass('erroneous-input');
  $(".error-message").empty();

  var messageWrapper = $(".message-wrapper");
  messageWrapper.empty().removeClass('alert');
}

function buttonToLoader(button){
  button.hide();
  $(".occasion-showbox").removeClass("hidden")
}

function cancelLoader(){
  $(".occasion-showbox").addClass("hidden")
  $(".occasion-submit-button,.school-group-sales-submit-button").show();
}

function scrollToMessage(data){
  // if ( data.form_type == "school fundraiser"){
  //   var topOffset = 800
  // } else {
  //   var topOffset = 360
  // }
  $(document.body).animate({
    'scrollTop':   $('#error-message-scroll').offset().top - 130
  }, 500 );
}

function resetFormInputs(){
  console.log("resetting form input values")
  $("input[type=text]").val("");
  $("select").find("option[value='']").attr('selected', 'selected').change();

}

function closeOpenedAccordians(){
  $('.form-dropdown').next().slideUp(300).addClass('closed')
}

function GetURLParameter(sParam){
  var sPageURL = window.location.search.substring(1);
  var sURLVariables = sPageURL.split('&');
  for (var i = 0; i < sURLVariables.length; i++) {
    var sParameterName = sURLVariables[i].split('=');
    if (sParameterName[0] === sParam){
      return sParameterName[1];
    }
  }
}

function openEventTab(eventId){
  $('.events-accordian').click();
  $('.accordion-event-section-content.event-id-'+eventId).show();
  var eventTabHeight = $('.accordion-event-section-content.event-id-'+eventId).height();
  var eventTabOffSet= $('.accordion-event-section-content.event-id-'+eventId).offset().top;
  if ( $(window).width() <= 768 ) {
    var headerHeight = $('header .mobile').height();
  } else {
    var headerHeight = $('#header').height();
  }
  var scrollToHeight = ( (eventTabOffSet - eventTabHeight) - headerHeight)
  console.log(scrollToHeight)
  $('body').animate({
    scrollTop: (scrollToHeight ) 
  });
}



