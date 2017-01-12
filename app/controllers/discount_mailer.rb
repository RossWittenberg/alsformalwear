if defined?(ActionMailer)
  class DiscountMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers
    include Rails.application.routes.url_helpers
    include Spree.railtie_routes_url_helpers   


		def discount_form(discount_params)
  		location = Location.find discount_params[:location_id] unless discount_params[:location_id].blank?
      if Rails.env.development? || Rails.env.test?
        recipients = [ 
          { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' }
        ]
      else
        recipients =[ 
          { type: "to", name: "#{discount_params[:first_name]} #{discount_params[:last_name]}", email: discount_params[:contact_email] }
        ]
      end

      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
      }
      MANDRILL.messages.send_template 'al-s-discount-coupon', [], message	
		end

    def discount_form_submission(discount_params)
      location = Location.find discount_params[:location_id] unless discount_params[:location_id].blank?
      if Rails.env.development? || Rails.env.test?
        recipients = [ 
          { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' }
        ]
      else
        recipients = [ 
            { type: "to", name: location.store_name || "N/A", email: location.email || "N/A"  },
            { type: "cc", name: "Follow-ups", email: "followups@alsformalwear.com"},
            { type: "cc", name: "Marketing", email: "marketing@alsformalwear.com" },
            { type: "bcc", name: "Al's @ V+V", email: "als@verbalplusvisual.com" }
          ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars: [
        {name: "DATE_SUBMITTED",
         content: Time.now.strftime("%D") 
        },
        {name: "FIRST_NAME",
         content: discount_params["first_name"] || "Not provided"
        },
        {name: "LAST_NAME",
         content: discount_params["last_name"] || "Not provided"
        },
        {name: "EMAIL",
         content: discount_params["contact_email"] || "Not provided"
        },
        {name: "PHONE",
         content: discount_params["contact_phone"] || "Not provided"
        },
        {name: "ZIP",
         content: discount_params["zip_code"] || "Not provided"
        },
        {name: "PRED_ALS_LOCATION_NAME",
         content:  location && location.store_name || "Not provided"
        },
        {name: "PREF_ALS_LOCATION_ADDRESS",
         content: location && location.street_address || "Not provided"
        },
        {name: "EVENT_DATE",
         content: discount_params["date"] || "Not provided"
        },
        {name: "EVENT_TYPE",
         content: discount_params["event_type"].humanize || "Not provided"
        }
        ]
      }
      MANDRILL.messages.send_template 'general-discount-submission', [], message 

    end
	end
end


