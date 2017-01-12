Spree::UsersController.class_eval do

  include Spree
  include DeviseHelper
  include MeasurementsHelper



	def show
    @user = spree_current_user
    @favorites_array = @user.favorites.pluck(:variant_id).uniq
    @favorites = Spree::Variant.find(@favorites_array)
		@suit_sizes = MeasurementsHelper::SUIT_SIZES_ARRAY
		@shirt_collars = MeasurementsHelper::SHIRT_COLLAR_ARRAY
		@shirt_sleeves = MeasurementsHelper::SHIRT_SLEEVE_ARRAY
		@shoe_sizes = MeasurementsHelper::SHOE_SIZES_ARRAY
		@fit_preferences = MeasurementsHelper::FIT_PREFERENCES_ARRAY
		@body_types = MeasurementsHelper::BODY_TYPES_ARRAY
		@events = @user.events.order(date: :asc)
		if @user.measurement.present?
			@measurement = @user.measurement
		else
			@measurement = Measurement.new
		end
		@other_contents = Content.where(page: "other")
    @custom_meta_tags = true
	end

	def update
    @user = Spree::User.find(params[:id])
    if @user.update(user_params)
      render json: { message: "You have successfully updated to your account.", user: @user }.to_json
    else
      @error_attributes = @user.errors.keys.flatten.map(&:to_s)#.map {|e| e.gsub("_", " ").titleize}
      @error_messages = @user.errors.full_messages.flatten
      render json: { error_messages: @error_messages, error_attributes: @error_attributes }.to_json
    end
	end

	private

	def user_params
    params.require(:user).permit!
  end

end