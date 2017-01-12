class EventsController < Spree::StoreController
  include Spree
  include DeviseHelper
  include EventsHelper

  before_filter :signed_in?

  def variant_look_up
    @variant = Spree::Variant.find params[:product_id]
    # render json: @variant.to_json
    render json: @variant, serializer: Spree::VariantSerializer, root: "variant"
  end

  def print
    @look = Look.find params[:look_id]
    @products = @look.products
    respond_to do |format|
      format.html {render :layout => 'spree/layouts/print_look' }
    end
  end

  def download
    @user = spree_current_user
    if @user.admin?
      @events = Event.all
      respond_to do |format|
        format.csv { send_data @events.to_csv }
      end
    else
      return
    end
  end

  def users_download
    @user = spree_current_user
    if @user.admin?
      @users = Spree::User.all
      respond_to do |format|
        format.csv { send_data @users.to_users_csv }
      end
    else
      return
    end
  end

  def appointments_download
    @user = spree_current_user
    if @user.admin?
      respond_to do |format|
        format.csv { send_data Appointment.to_csv }
      end
    else
      return
    end
  end

  def index
    @user = spree_current_user
    @events = @user.events.order(date: :desc)
  end

  def select
    @user = spree_current_user
    if params[:look_id]
      @look = Look.find params[:look_id]
    end
    @event = Event.new
    @events = @user.events.where( "date > ?", Time.zone.now.beginning_of_day)
    @roles = EventsHelper::WEDDING_ROLES
    @event_types = EventsHelper::EVENT_TYPES
  end

  def new
    @user = spree_current_user
    @event = Event.new
    @roles = EventsHelper::WEDDING_ROLES
    @event_types = EventsHelper::EVENT_TYPES
  end

  def edit    
    @user = spree_current_user
    @event = Event.find(params[:id])
    @look = @event.look
    @roles = EventsHelper::WEDDING_ROLES
    @event_types = EventsHelper::EVENT_TYPES
  end

  def create
    @user = spree_current_user

    if params[:event][:look_id].present?
      @look = Look.find(params[:event][:look_id])
    else
      @look = Look.create({}) unless params[:event][:look_id].present?
    end

    @event = Event.new(event_params)
    @event.date = DateTime.strptime(params[:event]["date"], "%m/%d/%Y") if ( params[:event].present? && params[:event]["date"].present?)
    @event.event_date_string = params[:event]["date"] unless @event.date.class == Date
    @event.look = @look
    if @event.save
      EventMailer.event_created_submission(event_params, @event, @user).deliver_now
      @user.events << @event
      @event.look.save
      @look.save
      @user.save
      @success_message = "Your new event has been created!"
      render json: { redirect: '/catalog/account?event='+"#{@event.id}", success_message: @success_message }.to_json
    else
      @error_messages = @event.errors.messages.values.uniq.compact.map(&:flatten).flatten
      @error_attributes = @event.errors.keys.flatten.map(&:to_s)#.map {|e| e.gsub("_", " ").titleize}
      render json: { error_messages: @error_messages, error_attributes: @error_attributes }.to_json and return
    end
  end

  def update
    @user = spree_current_user
    @event = Event.find(params[:id])
    event_params["date"] = DateTime.strptime(params[:event]["date"], "%m/%d/%Y") if ( params[:event].present? && params[:event]["date"].present?)
    if @event.update(event_params)
      @look = @event.look if @event.look.present?
      @success_message = "Your event has been updated!"
      render json: { redirect: "/catalog/account", success_message: @success_message }.to_json
    else
      @error_messages = @event.errors.messages.values.uniq.compact.map(&:flatten).flatten
      @error_attributes = @event.errors.keys.flatten.map(&:to_s)#.map {|e| e.gsub("_", " ").titleize}
      render json: { error_messages: @error_messages, error_attributes: @error_attributes }.to_json and return
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if params[:admin] && @event.present?
      @event.destroy
      params[:tabtag].present? ? tabtag = params[:tabtag] : tabtag = "proms"
      @destroy_message = "Your event has been deleted"
      redirect_to "/catalog/admin/leads#"+"#{tabtag}"
    else
      if @event.destroy
        respond_to do |format|
          format.html do
            @destroy_message = "Your event has been deleted"
            redirect_to "/catalog/account"
          end
          format.json do
            render json: { 
              user: @user, 
              event: @event, 
              look: @event.look }.to_json
          end  
        end 
      else
        @errors = @event.errors.full_messages
        render json: { error_messages: @errors }.to_json
      end
    end  
  end
  
  def create_with_group_code
    @user = spree_current_user
    @event = Event.new(event_params)
    @event.add_group_code if @event.location && @event.location.group_codes.present? && @event.is_group?
    @form_type = params[:form_type] if params[:form_type].present?
    
    @event.date = DateTime.strptime(params[:event]["date"], "%m/%d/%Y") if ( params[:event].present? && params[:event]["date"].present?)
      
    @event.event_date_string = params[:event]["date"] unless @event.date.class == Date

    if event_params && event_params[:orgname].present?

      high_school_name = event_params[:orgname]

      @high_school = HighSchool.find_by_name high_school_name
    end 
    
    @event.high_school = @high_school unless @high_school.blank?

    if @event.save
      @user.events << @event
      @user.save
      if params[:form_type] && params[:form_type] == "school fundraiser"
        location_id = event_params[:location_id]
        PromMailer.school_fund_raising_submission(event_params, @event, @user).deliver_now
        PromMailer.school_fund_raising(event_params, @event, @user).deliver_now
        form_specific_success_message = "Registration Complete! Please check your email for additional information."
      elsif params[:form_type] && params[:form_type] == "prom rep"
        PromMailer.prom_rep_program_submission(event_params, @event, @user).deliver_now
        PromMailer.prom_rep_program(event_params, @event, @user).deliver_now
        form_specific_success_message = "Registration Complete! Please check your email for additional information."
      elsif params[:form_type] && params[:form_type] == "social event"
        SocialEventMailer.social_event_fundraising(event_params, @event, @user).deliver_now
        SocialEventMailer.social_event_fundraising_submission(event_params, @event, @user).deliver_now
        form_specific_success_message = "Congratulations! Registration complete. Please check your email for more information."
      end
      if params[:event] && params[:event][:event_type] && params[:event][:event_type] == "wedding"
        WeddingMailer.wedding_sweepstakes_submission(event_params).deliver_now
        WeddingMailer.wedding_sweepstakes(event_params, @user).deliver_now
      end
      success_message = form_specific_success_message || "Congratulations! Registration complete."
      render json: { redirect: '/catalog/account?event='+"#{@event.id}",
                     success_message: success_message,
                     form_type: @form_type }.to_json
    else
      @error_attributes = @event.errors.keys.flatten.map(&:to_s)#.map {|e| e.gsub("_", " ").titleize}
      @error_messages = @event.errors.messages.values.uniq.compact.map(&:flatten).flatten
      render json: { error_messages: @error_messages, error_attributes: @error_attributes, form_type: @form_type }
    end
  end

  def update_with_group_code
    @user = spree_current_user
    @event = Event.find(params[:id])
    @form_type = params[:form_type] if params[:form_type].present?
    event_params[:date] = @event.date if @event && @event.date.present?
    if @event.update(event_attrs)
      @event.add_group_code if @event.location && @event.location.group_codes.present?
      @event.location = @event.group_code.location
      @event.save
      if params[:event] && params[:event][:event_type] && params[:event][:event_type] == "wedding"
        WeddingMailer.wedding_sweepstakes_submission(event_params).deliver_now
        WeddingMailer.wedding_sweepstakes(event_params, @user).deliver_now
      elsif params[:event] && params[:event][:event_type] && params[:event][:event_type] == "prom"
        if @form_type == "prom rep"
          PromMailer.prom_rep_program_submission(event_params, @event, @user).deliver_now
          PromMailer.prom_rep_program(event_params, @event, @user).deliver_now
          form_specific_success_message = "Registration Complete! Please check your email for additional information."
        elsif @form_type == "school fundraiser"
          PromMailer.school_fund_raising_submission(event_params, @event, @user).deliver_now
          PromMailer.school_fund_raising(event_params, @event, @user).deliver_now
          form_specific_success_message = "Registration Complete! Please check your email for additional information."
        end
      elsif params[:event] && params[:event][:event_type] && params[:event][:event_type] == "social event"
        SocialEventMailer.social_event_fundraising(event_params, @event, @user).deliver_now
        SocialEventMailer.social_event_fundraising_submission(event_params, @event, @user).deliver_now
      end
      success_message = form_specific_success_message || "Congratulations! Registration complete."
      render  json: { 
                redirect: '/catalog/account?event='+"#{@event.id}",
                event: @event,
                success_message: success_message,
                form_type: @form_type }.to_json
    else
      @error_attributes = @event.errors.keys.flatten.map(&:to_s)#.map {|e| e.gsub("_", " ").titleize}
      @error_messages = @event.errors.messages.values.uniq.compact.map(&:flatten).flatten
      render json: { error_messages: @error_messages, error_attributes: @error_attributes }
    end
  end

  def signed_in?
    if spree_current_user
      return
    else
      redirect_to spree_login_path, notice: "Login or create and account to create and event."
    end
  end


  def high_schools
    if params[:search] && params[:search][:query]
      @high_schools = HighSchool.ransack(name_cont: params[:search][:query]).result(distinct: true).limit(25)
      render json: @high_schools, root: "high_schools"
    end
  end

  private 

  def check_format
    render :nothing => true, :status => 406 unless params[:format] == 'json'
  end

  def event_params
    params.require(:event).permit!#(:event_name, :date, :event_type, :role, :groom_first_name, :groom_last_name )
  end
  
  def event_attrs
    event_attrs = event_params.clone
    event_attrs.delete "event_name"
    event_attrs.delete "date"
    return event_attrs
  end

end


    