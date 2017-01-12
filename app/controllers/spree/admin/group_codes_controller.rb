module Spree	
	module Admin
		class GroupCodesController < BaseController
	  	include Spree
			helper 'spree/admin/navigation'

			def index
    		@locations = Location.all.order(state: :asc).order(city: :asc).order(store_name: :asc)
				@header_text = "Add Group Codes to Location"
			end

			def create
				if params[:selectedLocationId].present?
					@location = Location.find params[:selectedLocationId]
				else 
					@error_message = "Please select a location."
					render json: {errorMessage: @error_message}	and return
				end
				if params[:startingNum] && params[:endingNum] && GroupCode.validateStartAndEndNum(params[:startingNum], params[:endingNum])
					@newGroupCodes = GroupCode.newGroupCodesFromAdmin(params[:startingNum], params[:endingNum], @location)
					if @newGroupCodes.count == 1
						render json: {errorMessage: "One or more of the group code numbers you have selected #{@newGroupCodes[:number][0]}"} and return
					else
						render json: { newGroupCodes: @newGroupCodes, location: @location, newCodesCount: @newGroupCodes.count } and return
					end
				else
					@error_message = "Please enter valid start and end numbers"
					render json: {errorMessage: @error_message} and return
				end
			end

			def location_info
				@location = Location.find params[:locationId]
				@groupCodeStatus = @location.running_low_on_codes?
				render json: { groupCodeStatus: @groupCodeStatus } and return
			end
		
		end
	end
end
