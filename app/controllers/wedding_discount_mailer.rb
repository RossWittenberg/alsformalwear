if defined?(ActionMailer)
  class WeddingDiscountMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers

    def custom_wedding_discount_submission(discount_params)
      location = Location.find discount_params[:location_id] unless discount_params[:location_id].blank?
      wedding_date = discount_params[:date]
      contact_email = discount_params[:contact_email]
      coupon_total = discount_params[:custom_discount]
      contact_name = discount_params[:contact_name]
      contact_phone = discount_params[:contact_phone]
      if discount_params[:best_man].to_i === 1
        best_man = 'Yes'
      else 
        best_man = 'No'
      end
      if discount_params[:groomsmen].to_i > 0
        groomsmen = discount_params[:groomsmen]
      else
        groomsmen = 'No'
      end
      if discount_params[:fot_bride].to_i === 1
        father_bride = 'Yes'
      else
        father_bride = 'No'
      end
      if discount_params[:fot_bride].to_i === 1
        father_groom = 'Yes'
      else
        father_groom = 'No'
      end
      if discount_params[:ringbearer].to_i === 1
        ringbearer = 'Yes'
      else
        ringbearer = 'No'
      end
      if discount_params[:ushers].to_i > 0
        ushers = discount_params[:ushers]
      else
        ushers = 'No'
      end
      if discount_params[:attendants].to_i > 0
        other_attendants = discount_params[:attendants]
      else
        other_attendants = 'No'
      end

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ 
            { type: "to", name: location.store_name, email: location.email || "N/A"  },
            # { type: "cc", name: "Store Manager", email: location.manager_email || "N/A" },
            # { type: "cc", name: "Area Manager", email: location.area_manager_email || "N/A" },
            { type: "cc", name: "Follow-ups", email: "followups@alsformalwear.com"},
            { type: "cc", name: "Marketing", email: "marketing@alsformalwear.com" }
          ]
      end


      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars:[
          {name: "DATE_SUBMITTED",
          content: Time.now.strftime("%D") },
          {name: "EMAIL",
          content: contact_email},
          {name: "CONTACT_NAME",
          content: contact_name},
          {name: "CONTACT_PHONE",
          content: contact_phone},
          {name: "EVENT_DATE",
          content: wedding_date },
          {name: "PREF_ALS_LOCATION_NAME",
          content: location && location.store_name || "Not Provided"},
          {name: "PREF_ALS_LOCATION_ADDRESS",
          content: location && location.street_address || "Not Provided"},
          {name: "BEST_MAN",
          content:  best_man},
          {name: "GROOMSMEN",
          content:  groomsmen},
          {name: "FATHER_BRIDE",
          content:  father_bride},
          {name: "FATHER_GROOM",
          content:  father_groom},
          {name: "RINGBEARER",
          content:  ringbearer},
          {name: "USHERS",
          content:  ushers},
          {name: "OTHER_ATTENDANTS",
          content:  other_attendants},
          {name: "CUSTOM_DISCOUNT",
          content: "$#{coupon_total}.00" }
        ]
      }
      MANDRILL.messages.send_template 'custom-wedding-discount-submission', [], message
    end

    def custom_wedding_discount(discount_params)
      contact_email = discount_params[:contact_email]
      coupon_total = discount_params[:custom_discount]

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ { type: 'to', name: 'CUSTOM DISCOUNT RECIPIENT', email: contact_email } ]
      end

      if discount_params[:best_man].to_i === 1
        best_man = 'Yes'
      else 
        best_man = 'No'
      end
      if discount_params[:groomsmen].to_i > 0
        groomsmen = discount_params[:groomsmen]
      else
        groomsmen = 'No'
      end
      if discount_params[:fot_bride].to_i === 1
        father_bride = 'Yes'
      else
        father_bride = 'No'
      end
      if discount_params[:fot_bride].to_i === 1
        father_groom = 'Yes'
      else
        father_groom = 'No'
      end
      if discount_params[:ringbearer].to_i === 1
        ringbearer = 'Yes'
      else
        ringbearer = 'No'
      end
      if discount_params[:ushers].to_i > 0
        ushers = discount_params[:ushers]
      else
        ushers = 'No'
      end
      if discount_params[:attendants].to_i > 0
        other_attendants = discount_params[:attendants]
      else
        other_attendants = 'No'
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars: [
          {name: "CUSTOM_DISCOUNT",
          content: "$#{coupon_total}.00" },
          {name: "BEST_MAN",
          content:  best_man},
          {name: "GROOMSMEN",
          content:  groomsmen},
          {name: "FATHER_BRIDE",
          content:  father_bride},
          {name: "FATHER_GROOM",
          content:  father_groom},
          {name: "RINGBEARER",
          content:  ringbearer},
          {name: "USHERS",
          content:  ushers},
          {name: "OTHER_ATTENDANTS",
          content:  other_attendants}
        ]
      }

      MANDRILL.messages.send_template 'al-s-wedding-discount-coupon-1', [], message
    end

  end
end
