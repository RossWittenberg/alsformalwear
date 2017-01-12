class LocationsController < Spree::StoreController

	include Spree
  include DeviseHelper

  before_filter :check_format,  except: [:index, :show]

  def fetch_hours
    @location = Location.find params[:location_id]
    day = params[:day]
    @open = @location.opened_hours(day)
    @close = @location.closed_hours(day)
    render json: { open: @open, close: @close}
  end

  def index
    @user = spree_current_user
    @locations = Location.all.order(state: :asc).order(city: :asc).order(store_name: :asc)
    respond_to do |format| 
      format.html do
        @colorado_locations = Location.where(state: "CO").order(store_name: :asc)
        @louisiana_locations = Location.where(state: "LA").order(store_name: :asc)
        @oklahoma_locations = Location.where(state: "OK").order(store_name: :asc)
        @texas_locations = Location.where(state: "TX").order(store_name: :asc)
        @other_contents = Content.where(page: "other")
        @custom_meta_tags = true
        render :index
      end
      format.json do 
        response.headers['Vary'] = 'Accept'
        render json: {user: @user, locations: @locations }.to_json
      end
    end
  end

  def nearest
    @locations = Location.near([params[:location][:latitude], params[:location][:longitude]], 100).limit(12)
    if @locations.present? 
      render json: {locations: @locations}.to_json
    else
      @locations = Location.where(store_num: "17")
      @hq = @locations.clone
      @hq.flatten[0].phone_number = "1-800-460-8500"
      render json: {locations: @hq }.to_json
    end
  end

  def show
    @user = spree_current_user
    @location = Location.find_by_store_num params[:id]
    respond_to do |format| 
      format.html do
        render :show
      end
      format.json do 
        render json: { user: @user, locations: @hq }.to_json
      end
    end
  end


  private 

  def check_format
    render :nothing => true, :status => 406 unless params[:format] == 'json'
  end

end