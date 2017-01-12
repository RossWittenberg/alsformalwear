if defined?(ActionMailer)
  class ContactMailer < Devise::Mailer
  	def contact_form_submission(contact_params, contact)
  		location = Location.find contact_params[:location_id]

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients =[ { type: "to", name: contact.relevant_name, email: contact_params[:subject] } ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        # test
        to: recipients,
        global_merge_vars: [
        	{name: "DATE_SUBMITTED",
        	 content: Time.now.strftime("%D") },
          {name: "FIRST_NAME",
           content: contact_params[:first_name]},
          {name: "LAST_NAME",
           content: contact_params[:last_name]},
          {name: "EMAIL",
           content: contact_params[:contact_email]},
          {name: "ZIP",
           content: contact_params[:zip_code] },
          {name: "PHONE",
           content: contact_params[:contact_phone] },
          {name: "PREF_ALS_LOCATION_NAME",
           content: location.store_name },
          {name: "PREF_ALS_LOCATION_ADDRESS",
           content: location.street_address },
          {name: "MESSAGE",
           content: contact_params[:message] }
        ]
      }
      MANDRILL.messages.send_template 'contact-form-submission', [], message
  	end
  end

end







