if defined?(ActionMailer)
  class CapFormMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers

    def cap_form_submission(cap_params)
      orgname = cap_params[:orgname]
      address = cap_params[:street_address]
      city = cap_params[:city]
      state = cap_params[:state]
      zipcode = cap_params[:zip_code]
      tax_id = cap_params[:tax_id]
      referral = cap_params[:referral_name]
      first_name = cap_params[:first_name]
      last_name = cap_params[:last_name]
      title = cap_params[:contact_title]
      phone = cap_params[:contact_phone]
      contact_email = cap_params[:contact_email]
      location = Location.find cap_params[:location_id]
      

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ 
            { type: "to", name: "Account Management", email: "am@alsformalwear.com" },
            { type: "bcc", name: "Marketing", email: "marketing@alsformalwear.com" }
          ]
      end

      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars:[
          {name: "DATE_SUBMITTED",
          content: Time.now.strftime("%D") },
          {name: "ORG_NAME",
          content: orgname },
          {name: "ADDRESS",
          content: address },
          {name: "CITY",
          content: city },
          {name: "STATE",
          content: state },
          {name: "ZIP_CODE",
          content: zipcode },
          {name: "TAX_ID",
          content: tax_id },
          {name: "REFERRAL_NAME",
          content: referral },
          {name: "FIRST_NAME",
          content: first_name },
          {name: "LAST_NAME",
          content: last_name },
          {name: "TITLE",
          content: title },
          {name: "PHONE",
          content: phone },
          {name: "EMAIL",
          content: contact_email },
          {name: "PREF_ALS_LOCATION_NAME",
          content: location.store_name },
          {name: "PREF_ALS_LOCATION_ADDRESS",
          content: location.street_address }
        ]
      }
      MANDRILL.messages.send_template 'cap-form-submission', [], message
    end

    def cap_form(cap_params)
      orgname = cap_params[:orgname]
      address = cap_params[:street_address]
      city = cap_params[:city]
      state = cap_params[:state]
      zipcode = cap_params[:zip_code]
      tax_id = cap_params[:tax_id]
      referral = cap_params[:referral_name]
      first_name = cap_params[:first_name]
      last_name = cap_params[:last_name]
      title = cap_params[:contact_title]
      phone = cap_params[:contact_phone]
      contact_email = cap_params[:contact_email]
      location = Location.find cap_params[:location_id]

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ { type: 'to', name: 'CAP FORM REPRESENTATIVE', email: contact_email } ]
      end

      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars:[
          {name: "DATE_SUBMITTED",
          content: Time.now.strftime("%D") },
          {name: "ORG_NAME",
          content: orgname },
          {name: "ADDRESS",
          content: address },
          {name: "CITY",
          content: city },
          {name: "STATE",
          content: state },
          {name: "ZIP_CODE",
          content: zipcode },
          {name: "TAX_ID",
          content: tax_id },
          {name: "REFERRAL_NAME",
          content: referral },
          {name: "FIRST_NAME",
          content: first_name },
          {name: "LAST_NAME",
          content: last_name },
          {name: "TITLE",
          content: title },
          {name: "PHONE",
          content: phone },
          {name: "EMAIL",
          content: contact_email },
          {name: "PREF_ALS_LOCATION_NAME",
          content: location.store_name },
          {name: "PREF_ALS_LOCATION_ADDRESS",
          content: location.street_address }
        ]
      }

      MANDRILL.messages.send_template 'cap-form', [], message
    end

  end
end
