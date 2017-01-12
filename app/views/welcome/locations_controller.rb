module Spree	
	module Admin
		class LocationsController < BaseController
	  	include Spree
			helper 'spree/admin/navigation'
	  	def index
				@locations = Location.order :store_name
				@header_text = "Locations Dashboard"
		    respond_to do |format|
		      format.html {render :layout => 'spree/admin/layouts/admin' }
		    end
			end

			def show
				@location = Location.find_by_store_num params[:id]
				@header_text = "Location: #{@location.store_name}"
		    respond_to do |format|
		      format.html {render :layout => 'spree/admin/layouts/admin' }
		    end
			end

			def new
				@location = Location.new
				@header_text = "Add a New Location"
				@states = AMERICAN_STATES
			end

			def create 
				@location = Location.new(location_params)
				if @location.save
					flash[:success] = "New Location Added"
					redirect_to :admin_locations
				else
					@errors = @location.errors
					flash[:error] = @errors.full_messages[0]
					redirect_to :new_admin_location
				end
			end

			def edit
				@location = Location.find_by_store_num params[:id]
				@states = AMERICAN_STATES
				@header_text = "Edit Location"
			end

			def update
				@location = Location.find_by_store_num params[:id]
				if params[:delete_content_image_1]
					@location.content_image_1.clear
					@location.content_image_1.destroy
					@location.save
				end
				if params[:delete_content_image_2]
					@location.content_image_2.clear
					@location.content_image_2.destroy
					@location.save
				end
				if params[:delete_content_image_3]
					@location.content_image_3.clear
					@location.content_image_3.destroy
					@location.save					
				end

				if params[:delete_manager_image]
					@location.manager_image.clear
					@location.manager_image.destroy
					@location.save					
				end

				if @location.update_attributes(location_params)
					# flash[:success] = "Location Updated"
					flash[:success] = flash_message_for(@location, :successfully_updated)

					redirect_to "/catalog/admin/locations/#{@location.store_num}/edit"
				else
					@errors = @location.errors
					flash[:error] = @errors.full_messages[0]
					redirect_to "/catalog/admin/locations/#{@location.store_num}/edit"
				end
			end

			def destroy
				@location = Location.find_by_store_num params[:id]
				if @location.destroy
					flash[:success] = "Location Updated"
					redirect_to "/catalog/admin/locations"
				end
			end

			private
		  def location_params
		    params.require(:location).permit!
		  end
  	end
	end
end