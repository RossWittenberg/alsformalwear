var GROUP_CODES = {
	loaded: function(){
		console.log("group code js loaded");
	},
	listeners: function(){
		$('.cms-button.group-code-button').click(function(event) {
			console.log("group code button clicked");
			var selectedLocationId = $('#location_id').val();
			var startingNum = $('#starting_number').val();
			var endingNum = $('#ending_number').val();
			GROUP_CODES.submitGroupCodes(selectedLocationId, startingNum, endingNum);
		});
	},
	locationSelection: function(){
		console.log("backend locationSelection loaded");
		$('#location_id').change(function(event) {
			var selectedLocationId = $(this).val();
			GROUP_CODES.getLocationInfo(selectedLocationId);
		});
	},
	getLocationInfo: function(locationId) {
		$.ajax({
			url: '/catalog/admin/group_codes/location_info',
			type: 'GET',
			data: {locationId: locationId },
		})
		.done(function(data) {
			console.log("location info successfully retrieved");
			GROUP_CODES.displaySelectedLocationInfo(data);
		})
		.fail(function(data) {
			console.log("error");
		})
	},
	displaySelectedLocationInfo: function(data){
		console.log(data);
		var groupCodeStatus = data.groupCodeStatus;
		var selectedLocationTextElement = $('#selected-location-text');
		selectedLocationTextElement.text(groupCodeStatus).removeClass('cms-alert').removeClass('cms-success');;
	},
	submitGroupCodes: function(selectedLocationId, startingNum, endingNum){
		console.log("submitting form");
		$.ajax({
			url: '/catalog/admin/group_codes',
			type: 'POST',
			data: {
				selectedLocationId: selectedLocationId,
				startingNum: startingNum,
				endingNum: endingNum
			},
		})
		.done(function(data) {
			console.log("response successful");
			if (data.errorMessage && data.errorMessage.length > 0){
				var selectedLocationTextElement = $('#selected-location-text');
				var errorMessage = "There was an error adding new group codes. " + data.errorMessage;
				selectedLocationTextElement.text(errorMessage).addClass('cms-alert').removeClass('cms-success');
			} else {
				var selectedLocationTextElement = $('#selected-location-text');
				var successMessage = "Success! " + data.newCodesCount + " codes were added to store number " + data.location.store_num
				selectedLocationTextElement.text(successMessage).removeClass('cms-alert').addClass('cms-success');
			}
		})
		.fail(function() {
			console.log("error");
		})
		.always(function() {
			console.log("complete");
		});
		
	}
}

$(document).ready(function() {
	GROUP_CODES.loaded();
	GROUP_CODES.listeners();
	GROUP_CODES.locationSelection();
})
