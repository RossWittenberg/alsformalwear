class WelcomeController < Spree::StoreController
  respond_to :html
  include Spree
  include DeviseHelper
  include EventsHelper

	def index 
    @user = spree_current_user
    @home_contents = Content.where(page: "home")
    @custom_meta_tags = true
	end

	def about
    @user = spree_current_user
    @about_contents = Content.where page: "about"
    @custom_meta_tags = true
	end

	def byt
    @user = spree_current_user
    @other_contents = Content.where(page: "other")
    @custom_meta_tags = true
	end

	def wedding
    @user = spree_current_user
    if @user
      @weddings = @user.events.where( "date > ? AND event_type = ?", Time.zone.now.beginning_of_day, "wedding").select { |e| e.group_code.blank? }
    end
    @states = AMERICAN_STATES.reverse
    @locations = Location.all.order(state: :asc).order(city: :asc).order(store_name: :asc)
    wedding_variant_ids_array = [178,270,332,336,437,245]
    @featured_products = Spree::Variant.find(wedding_variant_ids_array).index_by(&:id).slice(*wedding_variant_ids_array).values
    @wedding_contents = Content.where(page: "wedding")
    @custom_meta_tags = true
  end

	def prom
    @user = spree_current_user
    if !@user.blank?
      @school_events = @user.events.where("date > ? AND event_type = ? OR event_type = ?", Time.zone.now.beginning_of_day, "prom_formal", "prom" ).select { |e| e.group_code.blank? }
    end
    @event = Event.new
    @states = AMERICAN_STATES.reverse
    @locations = Location.all.order(state: :asc).order(city: :asc).order(store_name: :asc)
    prom_variant_ids_array = [178,334,847,268,182,148]
    @featured_products = Spree::Variant.find(prom_variant_ids_array).index_by(&:id).slice(*prom_variant_ids_array).values
    @prom_contents = Content.where(page: "prom")
    @custom_meta_tags = true
	end

	def terms
    @user = spree_current_user
    @other_contents = Content.where(page: "other")
    @custom_meta_tags = true
	end

	def quinceanera
    @user = spree_current_user
    qunice_variant_ids_array = [276,62,182,184,370,245]
    @featured_products = Spree::Variant.find(qunice_variant_ids_array).index_by(&:id).slice(*qunice_variant_ids_array).values
	  @quinceanera_contents = Content.where page: "quinceanera"
    @custom_meta_tags = true
  end

  def social_event
    @user = spree_current_user
    @event = Event.new
    if !@user.blank?
      @social_events = @user.events.where("date > ? AND event_type = ? OR event_type = ?", Time.zone.now.beginning_of_day, "social_event", "social event" ).select { |e| e.group_code.blank? }
    end
    @locations = Location.all.order(state: :asc).order(city: :asc).order(store_name: :asc)
    @states = AMERICAN_STATES.reverse
    social_variant_ids_array = [178,268,166,847,334,152]
    @featured_products = Spree::Variant.find(social_variant_ids_array).index_by(&:id).slice(*social_variant_ids_array).values
    @social_event_contents = Content.where(page: "social-event")
    @custom_meta_tags = true
  end

	def contact
    @user = spree_current_user
    @states = AMERICAN_STATES.reverse
    @locations = Location.all.order(state: :asc).order(city: :asc).order(store_name: :asc)
    @contact_contents = Content.where(page: "contact")
	end

  def group_offers
    @user = spree_current_user
    @group_offers_contents = Content.where(page: "group_offers")
    @custom_meta_tags = true
  end

  def discount
    @user = spree_current_user
    @event = Event.new
    @event_types = EventsHelper::EVENT_TYPES
    @locations = Location.all.order(state: :asc).order(city: :asc).order(store_name: :asc)
    @states = AMERICAN_STATES.reverse
  end

  def cap
    @locations = Location.all.order(state: :asc).order(city: :asc).order(store_name: :asc)
    @states = AMERICAN_STATES.reverse
  end

  def sitemap
  end

end