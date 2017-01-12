var EVENT = {
  listeners: function(){
    $(".event-type-select").change(function (e) {
      console.log("event selected");
      if ( $('.event-type-select :selected').val() === "wedding"){
      	showRole();
        hideExplain();
      } else if( $('.event-type-select :selected').val() === "other" ) {
        showExplain();
        hideRole();
      } else {
      	hideRole();
      	hideNames();
        hideExplain();
      }
    })
    $(".event-role-select").change(function (e) {
      console.log("role selected");
      if ( $('.event-role-select :selected').val() === "groom" ){
      	showBrideNames();
      	hideGroomNames();
      	hideEventNames();
      } else if ( $('.event-role-select :selected').val() === "bride" ) {
      	showGroomNames()
      	hideBrideNames();
      	hideEventNames();
      } else if ( ( $('.event-role-select :selected').val() === "groomsman" ) || ( $('.event-role-select :selected').val() === "other"  ) ) {
      	showEventNames()
      	hideGroomNames();
      	hideBrideNames();
      }
    });
    $(".update-event").click(function(event) {
      event.preventDefault();
      var button = $(this)
      EVENT.buttonToLoader(button);
      var id = $(".update-event-id").val()
      $.ajax({
       type: "PUT",
        url: '/events/'+id,
        data: $("form.event-edit").serialize(),
        success: function(data) {
          EVENT.cancelLoader();
          if ( data.error_messages !== undefined ){
            displayOccasionErrorIndicators(data);
          } else {
            EVENT.confirmFormsSuccess(data);
          }
        },
        failure: function(data) {
          console.log(data)
        }
      })

    });

    $(".new-event,.new-event-on-select-button").click(function(event) {
      event.preventDefault();
      var button = $(this)
      EVENT.buttonToLoader(button);
      $.ajax({
       type: "POST",
        url: '/events',
        data: $("form.new-event-on-select,form.event-new").serialize(),
        success: function(data) {
          EVENT.cancelLoader();
          if ( data.error_messages !== undefined ){
            displayOccasionErrorIndicators(data);
          } else {
            EVENT.confirmFormsSuccess(data);
          }
        },
        failure: function(data) {
          console.log(data)
        }
      })
    });
    $(".update-event-on-select-button").click(function(event) {
      event.preventDefault();
      var button = $(this)
      EVENT.buttonToLoader(button);
      console.log("existing event on select - form submitted")
      var eventId = $(".existing-events-form-field option:selected").val();
      var lookId = $(".look-id-for-select-event").val()
      $.ajax({
       type: "PUT",
        url: '/catalog/byt/event/'+eventId,
        data: { "format": "json", "look_id": lookId },
        success: function(data) {
          EVENT.cancelLoader();
          if ( data.error_messages !== undefined ){
            displayOccasionErrorIndicators(data);
          } else {
            EVENT.confirmFormsSuccess(data);
          }
        }
      })
    });
  },
  onReady: function(){
    console.log("event.js loaded")
  },
  buttonToLoader: function(button){
    button.hide();
    $(".event-showbox").removeClass("hidden")
  },
  cancelLoader: function(){
    $(".event-showbox").addClass("hidden")
    $(".new-event,.new-event-on-select-button,.update-event").show();
  },
  confirmFormsSuccess: function (data) {
    // var messageWrapper = $(".message-wrapper");
    // var successModal = $("#successModal");
    // var messageText = data.success_message;
    // $(".successModalMessage").text(messageText);
    // successModal.modal('show');
    // EVENT.clearErrors();
    // messageWrapper.removeClass('alert');
    // setTimeout(function(){
    //   successModal.modal('hide')
    // }, 2500);
    console.log("success");
    window.location.href = data.redirect;
  },
  clearErrors: function(){
    $(".erroneous-input").removeClass('erroneous-input');
    $(".error-message").empty();
    $(".message-wrapper").empty();
    var messageWrapper = $(".message-wrapper");
    messageWrapper.empty().removeClass('alert');
  },
}
// ROLE
function showRole() {
	var eventRoleSelect = $(".event-role-select");
	eventRoleSelect.removeClass('hidden').show();
}
function hideRole() {
	var eventRoleSelect = $(".event-role-select");
	eventRoleSelect.addClass('hidden').hide();
}
// OTHER
function showExplain() {
  var eventExplainSelect = $(".event-explain-text");
  eventExplainSelect.removeClass('hidden').show();
}
function hideExplain() {
  var eventExplainSelect = $(".event-explain-text");
  eventExplainSelect.addClass('hidden').hide();
}
// BRIDE
function showBrideNames() {
	var brideNames = $(".bride-name-input")
	brideNames.removeClass('hidden').show();
}
function hideBrideNames() {
	var brideNames = $(".bride-name-input")
	brideNames.addClass('hidden').hide();
}
// GROOM
function showGroomNames() {
	var groomNames = $(".groom-name-input")
	groomNames.removeClass('hidden').show();
}
function hideGroomNames() {
	var groomNames = $(".groom-name-input")
	groomNames.addClass('hidden').hide();
}
// EVENT NAME
function showEventNames() {
	var eventNames = $(".event-name-input")
	eventNames.removeClass('hidden').show();
}
function hideEventNames() {
	var eventNames = $(".event-name-input")
	eventNames.addClass('hidden').hide();
}

function hideNames() {
  hideBrideNames();
  hideGroomNames();
  hideEventNames();
}


$( document ).ready( EVENT.listeners );
$( document ).ready( EVENT.onReady );



// // create
// $.ajax({
//   url: '/events',
//   type: 'POST',
//   data: { 'format':'json', 
//           "event":{
//             "event_name":"event 1", 
//             "event_type": "wedding", 
//             "date": "Wed, 02 Dec 2015 18:41:34 UTC +00:00", 
//             "groom_first_name": "Ross", 
//             "groom_last_name":"Wittenberg", 
//             "look_id": "1"  }},
//   dataType: "json",
//   success: function(data){
//   	console.log(data);
//   },
//   failure: function(data){
//   	console.log(data);
//   }
// });

// // update
// $.ajax({
//   url: '/events/:id',
//   type: 'PUT',
//   data: { 'format':'json', 
//           "event":{
//             "event_name":"event 1", 
//             "event_type": "wedding", 
//             "date": "Wed, 02 Dec 2015 18:41:34 UTC +00:00", 
//             "groom_first_name": "Elliott", 
//             "groom_last_name":"Wittenberg", 
//             "look_id": "1"  }},
//   dataType: "json",
//   success: function(data){
//     console.log(data);
//   },
//   failure: function(data){
//     console.log(data);
//   }
// });

// // delete
// $.ajax({
//   url: '/events/:id',
//   type: 'DELETE',
//   data: { 'format':'json', "event":{ "id": event.id } },
//   dataType: "json",
//   success: function(data){
//     console.log(data);
//   },
//   failure: function(data){
//     console.log(data);
//   }
// });