$(document).ready(function(){

  
  var appointmentFormParam = GetURLParameter("appointment_form") || "";
  if (appointmentFormParam.length > 0 ){
    appointmentParamListener(appointmentFormParam);
  };

  $(".appointment-datepicker").datepicker({
      beforeShowDay: function (date) {
          return [( !isChristmas(date) && !isNewYearsDay(date) && !isJulyFourth(date) && !isThanksGiving2016(date) && !isThanksGiving2017(date) && !isThanksGiving2018(date) && !isThanksGiving2019(date) && !isThanksGiving2020(date) && !isThanksGiving2021(date) && !isLaborDay2016(date) && !isLaborDay2017(date) && !isLaborDay2018(date) && !isLaborDay2019(date) && !isLaborDay2020(date) && !isLaborDay2021(date) )];
      }
  });

  $('select#appointment_reason').on('change', function(){
    // var reason = $('select#appointment_reason');
    $("ul#appointment_reasonSelectBoxItOptions.selectboxit-options.selectboxit-list").css('display', 'none');
    if($(this).val() === 'Wedding') {
      $('div.wedding-det').removeClass('hidden');
      $('input#appointment_other_explain').parent().addClass('hidden');
    } else if ($(this).val() === 'Other') {
      $('input#appointment_other_explain').parent().removeClass('hidden');
      $('div.wedding-det').addClass('hidden');
    } else {
      $('div.wedding-det').addClass('hidden');
      $('input#appointment_other_explain').parent().addClass('hidden');
    }
  });
  
  $('#aptModal').on('shown.bs.modal', function(){
    console.log("emptying appointment modal message wrapper")
    $('.message-wrapper').empty().removeClass('alert').removeClass('success');
  })

  $('.selectboxit-text').attr('style', '');

  $('#appointment_apt_time__4iSelectBoxIt,#appointment_apt_time__5iSelectBoxIt').addClass('disabled');

  $('#appointment_location_id').change(function(event) {
    $(".appointment-store-closed-message").addClass('hidden');
    if ( $(this).val() !== null && $(this).val().length > 0 ){
      if ( $('#appointment_appointment_date').val().length > 0 ) {
        var locationId = $('#appointment_location_idSelectBoxItText').attr('data-val');
        var date = new Date($('#appointment_appointment_date').val())
        var day  = date.getDay();
        $('#appointment_apt_time__4iSelectBoxIt,#appointment_apt_time__5iSelectBoxIt').removeClass('disabled');
        $('.appointment-time-message').hide();
        getHours(day, locationId);
      } else {
        $('#appointment_apt_time__4iSelectBoxIt,#appointment_apt_time__5iSelectBoxIt').addClass('disabled');
        $('.appointment-time-message').show();
      }
    } else {
      $('#appointment_apt_time__4iSelectBoxIt,#appointment_apt_time__5iSelectBoxIt').addClass('disabled');
      $('.appointment-time-message').show();
    }
  });

   $('#appointment_appointment_date').change(function(event) {
      $(".appointment-store-closed-message").addClass('hidden');
     if ( $(this).val().length < 1 ){
      $('#appointment_apt_time__4iSelectBoxIt,#appointment_apt_time__5iSelectBoxIt').addClass('disabled');

      $('.appointment-time-message').show();
    } else {
      if ( $('#appointment_location_idSelectBoxItText').attr('data-val').length > 0 ) {
        var locationId = $('#appointment_location_idSelectBoxItText').attr('data-val');
        var date = new Date($('#appointment_appointment_date').val())
        var day  = date.getDay();
        $('#appointment_apt_time__4iSelectBoxIt,#appointment_apt_time__5iSelectBoxIt').removeClass('disabled');
        $('.appointment-time-message').hide();
        getHours(day, locationId);
      };
    }
   });

});

function getHours(day, locationId) {
  $.ajax({
    url: '/locations/hours',
    data: {'format': 'json', 
           'day': day,
           'location_id': locationId
          },
    success: function(data){
      changeHours(data)
      console.log(data);
    },
    failure: function(data){
      console.log(data);
    }  
  });
};

function changeHours(data) {
  if ( data.open === 99 ){
    storeClosed();
  } else { 
    var hoursSelect = $("select#appointment_apt_time__4i");
    var hoursValue = hoursSelect.val(); 
    var rangeOfHours = data.close - data.open;
    hoursSelect.data("selectBox-selectBoxIt").remove();
    hoursSelect.data("selectBox-selectBoxIt").add({value:"", text: "HOUR" });
    for (var i = 0; i <= rangeOfHours; i++) {
      var hour = data.open + i
      var formattedHour = hour > 12 ? hour - 12 : hour;
      var amPm = hour >= 12 ? "PM" : "AM";
      hoursSelect.data("selectBox-selectBoxIt").add({value: hour, text: formattedHour +" "+ amPm})
    };
    if ( parseInt(hoursValue) >= data.open && parseInt(hoursValue) <= data.close ) {
      hoursSelect.find("option[value='"+hoursValue+"']").attr('selected', 'selected').change();
    } else {
      hoursSelect.find("option[value='']").attr('selected', 'selected').change();
    }
  }
}

function storeClosed(){
  $(".appointment-store-closed-message").removeClass('hidden');
  var hoursSelect = $("select#appointment_apt_time__4i");
  var minutesSelect = $("select#appointment_apt_time__5i");
  var hoursValue = hoursSelect.val(); 
  var minutesValue = minutesSelect.val();
  hoursSelect.data("selectBox-selectBoxIt").remove();
  hoursSelect.data("selectBox-selectBoxIt").add({value:"", text: "HOUR" });
  minutesSelect.data("selectBox-selectBoxIt").add({value:"", text: "MINUTES" });
  $('#appointment_apt_time__4iSelectBoxIt,#appointment_apt_time__5iSelectBoxIt').addClass('disabled');

}


// holidays
function isChristmas(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    return (day === 25 && month === 12);
}

function isNewYearsDay(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    return (day === 1 && month === 1);
}

function isJulyFourth(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    return (day === 4 && month === 7);
}

function isLaborDay2016(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 5 && month === 9 && year === 2016);
}

function isLaborDay2017(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 4 && month === 9 && year === 2017);
}

function isLaborDay2018(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 3 && month === 9 && year === 2018);
}

function isLaborDay2019(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 2 && month === 9 && year === 2019);
}

function isLaborDay2020(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 7 && month === 9 && year === 2020);
}

function isLaborDay2021(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 6 && month === 9 && year === 2021);
}

function isThanksGiving2016(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 24 && month === 11 && year === 2016);
}

function isThanksGiving2017(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 23 && month === 11 && year === 2017);
}

function isThanksGiving2018(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 22 && month === 11 && year === 2018);
}

function isThanksGiving2019(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 28 && month === 11 && year === 2019);
}

function isThanksGiving2020(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 26 && month === 11 && year === 2020);
}

function isThanksGiving2021(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    return (day === 25 && month === 11 && year === 2021);
}

function appointmentParamListener(appointmentFormParam){
  if( appointmentFormParam === "true" ){
    $('#aptModal').modal('show');
  }; 
}

