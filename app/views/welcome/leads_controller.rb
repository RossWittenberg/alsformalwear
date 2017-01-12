module Spree	
	module Admin
		class LeadsController < BaseController
  	include Spree

  		helper 'spree/admin/navigation'

			def index
				@proms = Event.includes(:group_code).includes(:location).where("prom_rep = ? OR school_fundraiser = ? OR event_type = ? OR event_type = ?", true, true, "prom_formal", "prom")
				@weddings = Event.includes(:group_code).includes(:location).where("event_type = ?", "wedding")
				@social_events = Event.includes(:group_code).includes(:location).where("event_type = ? OR event_type = ?", "social_event", "social event")
				@others = Event.includes(:group_code).includes(:location).where event_type: "quinceanera"
				@appointments = Appointment.all
				@discounts = Discount.includes(:location).where(wedding: false)
				@wedding_discounts = Discount.includes(:location).where(wedding: true)
		    respond_to do |format|
		      format.html {render :layout => 'spree/admin/layouts/admin' }
		    end
			end
			
		end
	end
end
