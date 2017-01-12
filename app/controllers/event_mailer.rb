if defined?(ActionMailer)
  class EventMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers
    include Rails.application.routes.url_helpers
    include Spree.railtie_routes_url_helpers

    def event_created_submission(event_params, event, user)
      date = event_params[:date]
      if event.look.present?
        look = event.look
        look.products? ? look_link = '<a href="https://www.alsformalwear.com/events/print?look_id='+look.id.to_s+'" target="_blank">View Look</a>' : look_link = "N/A"
      end
      user.phone_number? ? phone_number = user.phone_number : "Not Provided"      
      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ Ross @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [{ type: "to", name: "Marketing", email: "marketing@alsformalwear.com"},
                      { type: "cc", name: "Follow-ups", email: "Followups@alsformalwear.com"},
                      { type: "cc", name: "Greg Williams", email: "Greg.Williams@alsformalwear.com"}
                     ]
        # recipients = [ { type: 'to', name: "Al's @ Ross @ V+V", email: 'ross@verbalplusvisual.com' } ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars:[
          {name:"DATE_SUBMITTED",
					 content: Time.now.strftime("%D")
					},
					{name:"EMAIL",
					 content: user.email
					},
					{name:"EVENT_NAME",
					 content: event.event_name
					},
					{name:"EVENT_DATE",
					 content: date
					},
					{name:"EVENT_TYPE",
					 content: event.event_type
					},
					{name:"ROLE",
					 content:event.role
					},
          {name: "BRIDE_FNAME",
           content: event_params[:bride_first_name] || "Not provided"
          },
          {name: "BRIDE_LNAME",
           content: event_params[:bride_last_name] || "Not provided"
          },
          {name: "GROOM_FNAME",
           content: event_params[:groom_first_name] || "Not provided"
          },
          {name: "GROOM_LNAME",
           content: event_params[:groom_last_name] || "Not provided"
          },
					{name:"USER_FNAME",
					 content: user.first_name || "Not provided"
					},
					{name:"USER_LNAME",
					 content: user.last_name || "Not provided"
					},
          {name:"USER_PHONE_NUMBER",
           content: phone_number
          },
          {name:"OTHER_EXPLAIN",
           content: event_params[:other_explain]
          },
          {name:"LOOK_LINK",
           content: look_link
          }          
        ]
      }
      MANDRILL.messages.send_template 'event-created-submission', [], message
    end
  end
end








