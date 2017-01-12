if defined?(ActionMailer)
  class WeddingMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers

    def wedding_sweepstakes(event_params, user)
      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ format_receipient_from_form(event_params, user) ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients
      }
      MANDRILL.messages.send_template 'wedding-sweepstakes', [], message
    end

    def wedding_sweepstakes_submission(event_params)
      location = Location.find event_params[:location_id]
      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ { type: 'to', name: 'Marketing', email: 'marketing@alsformalwear.com' }
                     ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars:[
          {name: "WEDDING_DATE", 
           content: event_params[:date] },
          {name: "DATE_SUBMITTED",
           content: Time.now.strftime("%D") },
          {name: "ROLE",
           content: event_params[:role] },
          {name: "FIRST_NAME",
           content: event_params[:first_name] },
          {name: "LAST_NAME",
           content: event_params[:last_name] },
          {name: "ADDRESS",
           content: event_params[:street_address] },
          {name: "CITY",
           content: event_params[:city] },
          {name: "STATE",
           content: event_params[:state] },
          {name: "ZIP",
           content: event_params[:zip_code] },
          {name: "PHONE",
           content: event_params[:contact_phone] },
          {name: "PREF_ALS_LOCATION_NAME",
           content: location.store_name },
          {name: "PREF_ALS_LOCATION_ADDRESS",
           content: location.street_address },
          {name: "BRIDE_FNAME",
           content: event_params[:bride_first_name] || "Not provided" },
          {name: "BRIDE_LNAME",
           content: event_params[:bride_last_name] || "Not provided" },
          {name: "BRIDE_EMAIL",
           content: event_params[:bride_email] || "Not provided" },
          {name: "GROOM_FNAME",
           content: event_params[:groom_first_name] || "Not provided"},
          {name: "GROOM_LNAME",
           content: event_params[:groom_last_name] || "Not provided"},
          {name: "GROOM_EMAIL",
           content: event_params[:groom_email] || "Not provided"}
        ]
      }
      MANDRILL.messages.send_template 'wedding-sweepstakes-submission', [], message
    end

    private

    def format_receipient_user user
      { type: 'to', name: "#{user.first_name} #{user.last_name}".strip, email: user.email }
    end
    def format_receipient_from_form(params, user)
      { type: 'to', name: "#{params[:first_name]} #{params[:first_name]}".strip, email: user.email  }
    end
  end
end







