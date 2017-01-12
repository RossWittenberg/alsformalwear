if defined?(ActionMailer)
  class MeasurementsMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers

    def my_measurements_submission(measurements_params, user)
      first_name = user.first_name || "Not Provided"
      last_name = user.last_name || "Not Provided"
      contact_email = user.email || "Not Provided"
      contact_phone = user.phone_number || "Not Provided"
      suit_size = measurements_params[:suit_size]
      chest_overarm = measurements_params[:chest_overarm]
      chest_underarm = measurements_params[:chest_underarm]
      pants_waist = measurements_params[:pants_waist]
      pants_hip = measurements_params[:pants_hip]
      pants_outseam = measurements_params[:pants_outseam]
      shirt_collar = measurements_params[:shirt_collar]
      shirt_sleeve = measurements_params[:shirt_sleeve]
      shoe_size = measurements_params[:shoe_size]
      weight = measurements_params[:weight]
      fit_preference = measurements_params[:fit_preference]
      body_type = measurements_params[:body_type]

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [
                       { type: 'to', name: 'Marketing', email: 'marketing@alsformalwear.com' },
                       { type: "cc", name: "Follow-ups", email: "Followups@alsformalwear.com"}
                     ]
      end

      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars:[
          {name: "DATE_SUBMITTED",
          content: Time.now.strftime("%D") },
          {name: "FIRST_NAME",
          content:  first_name},
          {name: "LAST_NAME",
          content:  last_name},
          {name: "EMAIL",
          content: contact_email},
          {name: "PHONE",
          content: contact_phone},
          {name: "SUIT_SIZE",
          content:  suit_size},
          {name: "CHEST_OVERARM",
          content:  "#{chest_overarm} inches" },
          {name: "CHEST_UNDERARM",
          content:  "#{chest_underarm} inches" },
          {name: "PANTS_WAIST",
          content:  "#{pants_waist} inches" },
          {name: "PANTS_HIP",
          content:  "#{pants_hip} inches"},
          {name: "PANTS_OUTSEAM",
          content:  "#{pants_outseam} inches" },
          {name: "SHIRT_COLLAR",
          content:  "#{shirt_collar} inches"},
          {name: "SHIRT_SLEEVE",
          content:  "#{shirt_sleeve} inches"},
          {name: "SHOE_SIZE",
          content:  shoe_size},
          {name: "HEIGHT",
          content: "#{measurements_params[:height_feet]} feet #{measurements_params[:height_inches]} inches" },
          {name: "WEIGHT",
          content:  "#{weight} pounds"},
          {name: "FIT_PREFERENCE",
          content:  fit_preference},
          {name: "BODY_TYPE",
          content:  body_type}
        ]
      }
      MANDRILL.messages.send_template 'my-measurements-submission', [], message
    end

  end
end