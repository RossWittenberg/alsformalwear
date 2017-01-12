class MeasurementsController < Spree::StoreController

	include Spree
  include DeviseHelper
  include MeasurementsHelper
  include OotmeasurementsHelper

  before_filter :signed_in?, :except => [:out_of_town_measurements, :out_of_town_measurements_submit]

  def index
    @user = spree_current_user
    @measurement = @user.measurement || Measurement.new
    @suit_sizes = MeasurementsHelper::SUIT_SIZES_ARRAY
    @shirt_collars = MeasurementsHelper::SHIRT_COLLAR_ARRAY
    @shirt_sleeves = MeasurementsHelper::SHIRT_SLEEVE_ARRAY
    @shoe_sizes = MeasurementsHelper::SHOE_SIZES_ARRAY
    @fit_preferences = MeasurementsHelper::FIT_PREFERENCES_ARRAY
    @body_types = MeasurementsHelper::BODY_TYPES_ARRAY
    @other_contents = Content.where page: "other"
    @custom_meta_tags = true
  end

  def update
    @user = spree_current_user
    @measurement = Measurement.find(params[:id])
    if @measurement.update(measurement_params)
      # MeasurementsMailer.my_measurements_submission(measurement_params, @user).deliver_now
      render json: { message: "Your mesaurements have been successfully updated."}.to_json
    else
      @error_attributes = @measurement.errors.keys.flatten.map(&:to_s)#.map {|e| e.gsub("_", " ").titleize}
      @error_messages = @measurement.errors.values.flatten.reverse
      render json: { error_messages: @error_messages, error_attributes: @error_attributes }.to_json
    end
  end

  def create
    @user = spree_current_user
    @measurement = Measurement.new(measurement_params)
    if @measurement.save
      @user.measurement = @measurement
      @user.save
      MeasurementsMailer.my_measurements_submission(measurement_params, @user).deliver_now
      render json: { message: "Your mesaurements have been successfully added to your account."}.to_json
    else
      @error_attributes = @measurement.errors.keys.flatten.map(&:to_s)#.map {|e| e.gsub("_", " ").titleize}
      @error_messages = @measurement.errors.values.flatten
      render json: { error_messages: @error_messages, error_attributes: @error_attributes }.to_json
    end
  end


  def destroy
  end

  def out_of_town_measurements
    @user = spree_current_user
    @measurement = @user ? @user.measurement : Measurement.new
    @suit_sizes = MeasurementsHelper::SUIT_SIZES_ARRAY
    @shirt_collars = MeasurementsHelper::SHIRT_COLLAR_ARRAY
    @shirt_sleeves = MeasurementsHelper::SHIRT_SLEEVE_ARRAY
    @shoe_sizes = MeasurementsHelper::SHOE_SIZES_ARRAY
    @fit_preferences = MeasurementsHelper::FIT_PREFERENCES_ARRAY
    @body_types = MeasurementsHelper::BODY_TYPES_ARRAY
    @locations = Location.all.order(state: :asc).order(city: :asc)
  end

  def out_of_town_measurements_submit
    
    params[:measurements]["suit_size"] = params["suit_size"]
    params[:measurements]["chest_overarm"] = params["chest_overarm"].to_i
    params[:measurements]["chest_underarm"] = params["chest_underarm"].to_i
    params[:measurements]["pants_waist"] = params["pants_waist"].to_i
    params[:measurements]["pants_hip"] = params["pants_hip"].to_i
    params[:measurements]["pants_outseam"] = params["pants_outseam"].to_i
    params[:measurements]["shirt_collar"] = params["shirt_collar"]
    params[:measurements]["shirt_sleeve"] = params["shirt_sleeve"]
    params[:measurements]["shoe_size"] = params["shoe_size"]
    params[:measurements]["height_feet"] = params["height_feet"]
    params[:measurements]["height_inches"] = params["height_inches"]
    params[:measurements]["weight"] = params["weight"]
    params[:measurements]["fit_preference"] = params["fit_preference"]
    params[:measurements]["body_type"] = params["body_type"]

    @measurements = OotMeasurement.new(params[:measurements])
    @measurements.date = DateTime.strptime(params[:measurements]["date"], "%m/%d/%Y") if ( params[:measurements].present? && params[:measurements]["date"].present?)
    @measurements.oot_date_string = params[:measurements]["date"] unless @measurements.date.class == Date
    if @measurements.valid?
      @success_message = "Thank you for submitting your Out of Town Measurements. An Al’s representative will reach out shortly."
      OotMailer.out_of_town_submission(params[:measurements]).deliver_now
      OotMailer.out_of_town(params[:measurements]).deliver_now
      render json: { success_message: @success_message }.to_json
    else
      @error_attributes = @measurements.errors.keys.map(&:to_s).reverse
      @error_messages = @measurements.errors.values.reverse
      render json: { error_messages: @error_messages}.to_json
    end
  end

  def validate
    @measurement = Measurement.new(measurement_params)
    @measurement.validate
    if @measurement.valid?
      if params["oot"]
        render json: { success_message: "valid", oot: "true" }.to_json
      else
        render json: { success_message: "valid" }.to_json
      end
    else
      @error_attributes = @measurement.errors.keys.flatten.map(&:to_s)
      @error_messages = @measurement.errors.values.flatten.first
      render json: { error_messages: @error_messages, error_attributes: @measurement.errors.keys.flatten.map(&:to_s) }.to_json
    end
  end

  def signed_in?
    if spree_current_user
      return
    else
      redirect_to spree_login_path, notice: "Login or create and account to create and event."
    end
  end

  private

  def measurement_params
    params.require(:measurement).permit!
  end


end