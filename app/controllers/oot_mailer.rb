if defined?(ActionMailer)
  class OotMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers

    def out_of_town_submission(oot_params)
      location = Location.find oot_params[:location_id]
      first_name = oot_params[:contact_first]
      last_name = oot_params[:contact_last]
      contact_email = oot_params[:contact_email]
      bride_name = oot_params[:bride_name]
      groom_name = oot_params[:groom_name]
      group_number = oot_params[:group_number]
      location_name = location.store_name
      location_address = location.street_address
      event_date = oot_params[:date]
      suit_size = oot_params[:suit_size]
      chest_overarm = oot_params[:chest_overarm]
      chest_underarm = oot_params[:chest_underarm]
      pants_waist = oot_params[:pants_waist]
      pants_hip = oot_params[:pants_hip]
      pants_outseam = oot_params[:pants_outseam]
      shirt_collar = oot_params[:shirt_collar]
      shirt_sleeve = oot_params[:shirt_sleeve]
      shoe_size = oot_params[:shoe_size]
      weight = oot_params[:weight]
      fit_preference = oot_params[:fit_preference]
      body_type = oot_params[:body_type]
      contact_phone = oot_params[:contact_phone]

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ { type: "to", name: location.store_name, email: location.email || "N/A"  },
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
          {name: "BRIDE_NAME",
          content:  bride_name},
          {name: "GROOM_NAME",
          content:  groom_name},
          {name: "GROUP_NUMBER",
          content:  group_number},
          {name: "PREF_ALS_LOCATION_NAME",
          content:  location_name},
          {name: "PREF_ALS_LOCATION_ADDRESS",
          content:  location_address},
          {name: "EVENT_DATE",
          content:  event_date},
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
          content: "#{oot_params[:height_feet]} feet #{oot_params[:height_inches]} inches" },
          {name: "WEIGHT",
          content:  "#{weight} pounds"},
          {name: "FIT_PREFERENCE",
          content:  fit_preference},
          {name: "BODY_TYPE",
          content:  body_type}
        ]
      }
      MANDRILL.messages.send_template 'out-of-town-measurements-submission', [], message
    end

    def out_of_town(oot_params)
      location = Location.find oot_params[:location_id]
      first_name = oot_params[:contact_first]
      last_name = oot_params[:contact_last]
      contact_email = oot_params[:contact_email]
      bride_name = oot_params[:bride_name]
      groom_name = oot_params[:groom_name]
      group_number = oot_params[:group_number] 
      location_name = location.store_name
      location_address = location.street_address
      location_phone = location.phone_number
      event_date = oot_params[:date]
      suit_size = oot_params[:suit_size]
      chest_overarm = oot_params[:chest_overarm]
      chest_underarm = oot_params[:chest_underarm]
      pants_waist = oot_params[:pants_waist]
      pants_hip = oot_params[:pants_hip]
      pants_outseam = oot_params[:pants_outseam]
      shirt_collar = oot_params[:shirt_collar]
      shirt_sleeve = oot_params[:shirt_sleeve]
      shoe_size = oot_params[:shoe_size]
      weight = oot_params[:weight]
      fit_preference = oot_params[:fit_preference]
      body_type = oot_params[:body_type]

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ { type: 'to', name: '#{first_name} #{last_name}', email: contact_email }
                     ]
      end

      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars:[
          {name: "DATE_SUBMITTED",
          content: Time.now.strftime("%D") },
          {name: "PREF_ALS_LOCATION_NAME",
          content: location_name},
          {name: "PREF_ALS_LOCATION_ADDRESS",
          content: location_address},
          {name: "LOCATION_PHONE",
          content: location_phone},
          {name: "SUIT_SIZE",
          content: suit_size},
          {name: "CHEST_OVERARM",
          content: chest_overarm},
          {name: "CHEST_UNDERARM",
          content: chest_underarm},
          {name: "PANTS_WAIST",
          content: pants_waist},
          {name: "PANTS_HIP",
          content: pants_hip},
          {name: "PANTS_OUTSEAM",
          content: pants_outseam},
          {name: "SHIRT_COLLAR",
          content: shirt_collar},
          {name: "SHIRT_SLEEVE",
          content: shirt_sleeve},
          {name: "SHOE_SIZE",
          content: shoe_size},
          {name: "HEIGHT",
          content: "#{oot_params[:height_feet]} feet #{oot_params[:height_inches]} inches" },
          {name: "WEIGHT",
          content: weight},
          {name: "FIT_PREFERENCE",
          content: fit_preference},
          {name: "BODY_TYPE",
          content: body_type}
        ]
      }
      MANDRILL.messages.send_template 'out-of-town-measurements', [], message
    end

  end
end