if defined?(ActionMailer)
  class SocialEventMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers
    include Rails.application.routes.url_helpers
    include Spree.railtie_routes_url_helpers 

    def social_event_fundraising(event_params, event, user)
      location = Location.find event_params[:location_id]
      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients =[ { type: "to", name: "#{event_params[:first_name]} #{event_params[:last_name]}", email: user.email  }
                    ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com"},
        to: recipients,
				global_merge_vars: [
          {name: "EMAIL",
           content: user.email},
          {name: "PREF_ALS_LOCATION_CITY",
           content: location.city },
          {name: "PREF_ALS_LOCATION_STATE",
           content: location.state },
          {name: "PREF_ALS_LOCATION_ZIP",
           content: location.zip_code },
          {name: "PREF_ALS_LOCATION_PHONE",
           content: location.phone_number },
          {name: "PREF_ALS_LOCATION_NAME",
           content: location.store_name },
          {name: "PREF_ALS_LOCATION_ADDRESS",
           content: location.street_address },
          {name: "GROUP_CODE",
           content: event.group_code.number}
        ]
      }
      MANDRILL.messages.send_template 'social-event-fundraising', [], message
    end

		def social_event_fundraising_submission(event_params, event, user)
      location = Location.find event_params[:location_id]
      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients =[ 
                      { type: "to", name: location.store_name, email: location.email || "N/A"  },
                      # { type: "to", name: "Store Manager", email: location.manager_email || "N/A" },
                      # { type: "to", name: "Area Manager", email: location.area_manager_email || "N/A" },
                      { type: "cc", name: "Account Management", email: "am@alsformalwear.com" },
                      { type: "cc", name: "Marketing", email: "marketing@alsformalwear.com" }
                    ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars: [
          {name: "DATE_SUBMITTED",
           content: Time.now.strftime("%D") },
          {name: "ORG_NAME",
           content: event.orgname},
          {name: "MAILING_ADDRESS",
           content: event.street_address},
          {name: "CITY",
           content: event.city},
          {name: "STATE",
           content: event.state},
          {name: "ZIP",
           content: event.zip_code},
          {name: "TAX_ID",
           content: event.tax_id},
          {name: "REFERRAL",
           content: event.referral_name || "N/A"},
          {name: "EVENT_NAME",
           content: event.event_name},
          {name: "JUNIORS_ATTEND",
           content: event.juniors},
          {name: "BLACK_TIE",
           content: event.black_tie},
          {name: "EVENT_DATE",
           content: event.date},
          {name: "EMAIL",
           content: user.email},
          {name: "REP_FIRST_NAME",
           content: event.first_name},
          {name: "REP_LAST_NAME",
           content: event.last_name},
          {name: "TITLE",
           content: event.contact_title || "N/A"},
          {name: "REP_PHONE",
           content: event.contact_phone},
          {name: "PREF_ALS_LOCATION_NAME",
           content: location.store_name },
          {name: "PREF_ALS_LOCATION_ADDRESS",
           content: location.street_address},
          {name: "GROUP_CODE",
           content: event.group_code.number || "N/A"}
        ]
      }
      MANDRILL.messages.send_template 'social-event-fundraising-submission', [], message
		end
  end
end