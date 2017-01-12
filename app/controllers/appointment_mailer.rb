if defined?(ActionMailer)
  class AppointmentMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers
    include Rails.application.routes.url_helpers
    include Spree.railtie_routes_url_helpers 
    	
  	def appointment_confirmation(appointment_params, appointment)
      location = Location.find appointment_params[:location_id]
      date = appointment_params[:appointment_date]
      if Rails.env.development? || Rails.env.test?
        recipients = [ 
            { type: "to", name: "TEST", email: "ross@verbalplusvisual.com" },
            { type: "cc", name: "ROSS", email: "ross.wittenberg@gmail.com" },
            { type: "to", name: "Al's @ Verbal + Visual", email: "als@verbalplusvisual.com" } 
          ]
      else
        recipients = [ { type: "to", name: "#{appointment_params[:first_name]} #{appointment_params[:last]}", email: appointment_params[:contact_email] }
                     ]
      end 
      appointment_params[:wedding_apt_details].present? ? reason2 =  appointment_params[:wedding_apt_details] : reason2 = appointment_params[:other_explain]
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com"},


        to: recipients,
        global_merge_vars: [
          {name:"APPOINTMENT_DATE",
           content: date
          },
          {name:"APPOINTMENT_TIME",
           content: appointment.demilitarize_time
          },
          {name:"PHONE",
           content: appointment_params[:contact_phone]
          },
          {name:"ZIP_CODE",
           content: appointment_params[:zip_code]
          },
          {name:"PREF_ALS_LOCATION_NAME",
           content: location.store_name
          },
          {name:"PREF_ALS_LOCATION_ADDRESS",
           content: location.street_address
          },
          {name:"PREF_ALS_LOCATION_CITY",
           content: location.city
          },
          {name:"PREF_ALS_LOCATION_STATE",
           content: location.state
          },
          {name:"PREF_ALS_LOCATION_ZIP",
           content: location.zip_code
          },
          {name:"PREF_ALS_LOCATION_PHONE",
           content: location.phone_number
          },           
          {name:"VISIT_REASON_1",
           content: appointment_params[:appointment_reason]
          },
          {name:"VISIT_REASON_2",
           content: reason2
          }
        ]
      }
      MANDRILL.messages.send_template 'make-an-appointment', [], message      
    end

    def make_an_appointment_submission_notification(appointment_params, appointment)
      location = Location.find appointment_params[:location_id]
      date = appointment_params[:appointment_date]
      event_date = appointment_params[:approximate_event_date]
      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: "to", name: "TEST", email: "ross@verbalplusvisual.com" },
                       { type: "cc", name: "TEST", email: "als@verbalplusvisual.com" }
                     ]
      else
        recipients = [ 
            { type: "to", name: location.store_name, email: location.email || "N/A"  },
            # { type: "cc", name: "Store Manager", email: location.manager_email || "N/A" },
            # { type: "cc", name: "Area Manager", email: location.area_manager_email || "N/A" },
            { type: "cc", name: "Web Customer Service", email: "webcsr@alsformalwear.com"},
            { type: "cc", name: "Follow-ups", email: "followups@alsformalwear.com"},
            { type: "cc", name: "Marketing", email: "marketing@alsformalwear.com" }
          ]
      end
      appointment_params[:group_code].present? ? group_code = appointment_params[:group_code] : group_code = "N/A"
      appointment_params[:wedding_apt_details].present? ? reason2 =  appointment_params[:wedding_apt_details] : reason2 = appointment_params[:other_explain]
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars: [
          {name: "DATE_SUBMITTED",
           content: Time.now.strftime("%D")
          },
          {name:"FIRST_NAME",
           content: appointment_params[:first_name]
          },
          {name:"LAST_NAME",
           content: appointment_params[:last_name]
          },
          {name:"PHONE",
           content: appointment_params[:contact_phone]
          },
          {name:"ZIP_CODE",
           content: appointment_params[:zip_code]
          },
          {name:"PREF_ALS_LOCATION_NAME",
           content: location.store_name
          },
          {name:"PREF_ALS_LOCATION_ADDRESS",
           content: location.street_address
          },
          {name:"PREF_CONTACT_TIME",
           content: appointment_params[:contact_time]
          },
          {name:"EMAIL",
           content: appointment_params[:contact_email]
          },
          {name:"PREF_CONTACT_METHOD",
           content: appointment_params[:contact_method]
          },
          {name:"APPOINTMENT_DATE",
           content: date
          },
          {name:"EVENT_DATE",
           content: event_date
          },
          {name:"APPOINTMENT_TIME",
           content: appointment.demilitarize_time
          },
          {name:"VISIT_REASON_1",
           content: appointment_params[:appointment_reason]
          },
          {name:"VISIT_REASON_2",
           content: reason2
          },
          {name:"APPT_MESSAGE",
           content: appointment_params[:message]
          },
          {name:"GROUP_CODE",
           content: appointment_params[:group_code] || "N/A"
          }          
        ]
      }
      MANDRILL.messages.send_template 'make-an-appointment-form-submission', [], message
    end

  end
end

