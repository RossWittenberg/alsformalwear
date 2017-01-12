class FormsController < ApplicationController
  include DeviseHelper

	def appointment
		@appointment = Appointment.new(appointment_params)
    
		if params[:appointment][:apt_time]["(4i)"].present? && params[:appointment][:apt_time]["(5i)"].present?
			@appointment.apt_time = Time.strptime( "#{params[:appointment][:apt_time]["(4i)"]}:#{params[:appointment][:apt_time]["(5i)"]}:00", "%H:%M:%S")
		else
			@appointment.apt_time = nil
		end

    if params[:appointment][:appointment_date].present?
      @appointment.appointment_date = DateTime.strptime( appointment_params[:appointment_date], "%m/%d/%Y")
    else
      @appointment.apt_time = nil
    end

    if params[:appointment][:approximate_event_date].present?
      @appointment.approximate_event_date = DateTime.strptime( appointment_params[:approximate_event_date], "%m/%d/%Y")
    end

		if @appointment.save
      @success_message = "Thank you for making an appointment at Al's! A representative will be in touch to confirm this appointment."
			AppointmentMailer.make_an_appointment_submission_notification(params[:appointment], @appointment).deliver_now
			AppointmentMailer.appointment_confirmation(params[:appointment], @appointment).deliver_now
      render json: {success_message: @success_message }.to_json
		else
      @error_attributes = @appointment.errors.keys.flatten.map(&:to_s)
      @error_messages = @appointment.errors.full_messages
			render json: { error_messages:  @error_messages, error_attributes: @error_attributes }.to_json
		end
	end

	def school_group_sales
		@school_group_sale = SchoolGroupSale.new(school_group_sale_params)
    @form_type = params[:form_type] if params[:form_type].present?

    @school_group_sale.deadline_string = params[:school_group_sale]["deadline"]
    @school_group_sale.deadline = DateTime.strptime(params[:school_group_sale]["deadline"], "%m/%d/%Y") if ( params[:school_group_sale].present? && params[:school_group_sale]["deadline"].present?)

		if @school_group_sale.save
      @success_message = "Thank you for contacting Al’s Formal Wear. An Al’s representative will reach out shortly."
			PromMailer.school_group_sales(school_group_sale_params).deliver_now
      render json: {success_message: @success_message, form_type: @form_type }.to_json
		else
      @error_attributes = @school_group_sale.errors.keys.flatten.map(&:to_s)
      @error_messages = @school_group_sale.errors.full_messages
			render json: { error_messages:  @error_messages, error_attributes: @error_attributes, form_type: @form_type }.to_json
		end
	end

	def contact
		@contact = Contact.new(params[:contact])
		if @contact.valid?
      @success_message = "Thank you for contacting Al’s Formal Wear. An Al’s representative will reach out shortly."
			ContactMailer.contact_form_submission(params[:contact], @contact).deliver_now
      render json: {success_message: @success_message }.to_json
		else
      @error_attributes = @contact.errors.keys.flatten.map(&:to_s)
      @error_messages = @contact.errors.full_messages
			render json: { error_messages:  @error_messages, error_attributes: @error_attributes }.to_json
		end
	end

	def discount
    @discount = Discount.new(discount_params)
    @discount.date = DateTime.strptime(discount_params["date"], "%m/%d/%Y") if ( discount_params.present? && discount_params["date"].present?)
    @discount.wedding_date_string = discount_params["date"] unless @discount.date.class == Date
    @location = Location.find(discount_params["location_id"]) if ( discount_params.present? && discount_params["location_id"].present? )
    @discount.location = @location unless @location.blank?
    if @discount.save
      @success_message = "Your discount coupon has been sent to your email."
      DiscountMailer.discount_form(discount_params).deliver_now
      DiscountMailer.discount_form_submission(discount_params).deliver_now
      render json: {success_message: @success_message }.to_json
    else
      @error_attributes = @discount.errors.keys.flatten.map(&:to_s)
      @error_messages = @discount.errors.full_messages
      render json: { error_messages:  @error_messages, error_attributes: @error_attributes }.to_json
    end
  end

	def wedding_discount
    @wedding_discount = Discount.new(wedding_discount_params)
    @wedding_discount.date = DateTime.strptime(wedding_discount_params["date"], "%m/%d/%Y") if ( wedding_discount_params.present? && wedding_discount_params["date"].present?)
    @wedding_discount.wedding_date_string = wedding_discount_params["date"] unless @wedding_discount.date.class == Date
    @location = Location.find(wedding_discount_params["location_id"]) if ( wedding_discount_params.present? && wedding_discount_params["location_id"].present? )
    @wedding_discount.location = @location unless @location.blank?
    if @wedding_discount.save
      @success_message = "Your discount coupon has been sent to your email."
      WeddingDiscountMailer.custom_wedding_discount_submission(wedding_discount_params).deliver_now
      WeddingDiscountMailer.custom_wedding_discount(wedding_discount_params).deliver_now
      render json: { success_message: @success_message }
    else
      @error_attributes = @wedding_discount.errors.keys.map(&:to_s)
      @error_messages = @wedding_discount.errors.full_messages
      render json: { error_messages: @error_messages, error_attributes: @error_attributes}.to_json
    end
	end

  def cap
    @cap = Cap.new(params[:cap])
    if @cap.valid?
      @success_message = "We have recieved your registration!"
      CapFormMailer.cap_form_submission(params[:cap]).deliver_now
      CapFormMailer.cap_form(params[:cap]).deliver_now
      render json: { success_message: @success_message }
    else
      @error_attributes = @cap.errors.keys.map(&:to_s)
      @error_messages = @cap.errors.full_messages
      render json: { error_messages: @error_messages, error_attributes: @error_attributes}.to_json
    end
  end

  def school_group_sale_params
    params.require(:school_group_sale).permit!#(:event_name, :date, :event_type, :role, :groom_first_name, :groom_last_name )
  end

  def appointment_params
    params.require(:appointment).permit!#(:event_name, :date, :event_type, :role, :groom_first_name, :groom_last_name )
  end

  def discount_params
    params.require(:discount).permit!#(:event_name, :date, :event_type, :role, :groom_first_name, :groom_last_name )
  end

  def wedding_discount_params
    params.require(:wedding_discount).permit!#(:event_name, :date, :event_type, :role, :groom_first_name, :groom_last_name )
  end

end





