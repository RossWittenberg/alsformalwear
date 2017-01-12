if defined?(ActionMailer)
  class PromMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers
    include Rails.application.routes.url_helpers
    include Spree.railtie_routes_url_helpers    

    def school_fund_raising(event_params, event, user)
      location = Location.find event_params[:location_id]
      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ { type: "to", name: "#{event_params[:first_name]} #{event_params[:last_name]}", email: user.email } ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
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
      MANDRILL.messages.send_template 'school-fund-raising-for-education-program', [], message
    end

    def school_fund_raising_submission(event_params, event, user)
      location = Location.find event_params[:location_id]
      event.juniors ? juniors = "YES" : juniors = "NO"
      event.number_juniors ? number_juniors = event.number_juniors : number_juniors = ''
      event.number_seniors ? number_seniors = event.number_seniors : number_seniors = ''
      event.black_tie ? black_tie = "YES" : black_tie = "NO"

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [  { type: "to", name: location.store_name, email: location.email || "N/A"  },
                        # { type: "to", name: "Store Manager", email: location.manager_email || "N/A" },
                        # { type: "to", name: "Area Manager", email: location.area_manager_email || "N/A" },
                        { type: "cc", name: "Marketing", email: "marketing@alsformalwear.com" },
                        { type: "cc", name: "AM", email: "am@alsformalwear.com" }
        ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: recipients,
        global_merge_vars: [
          {name: "DATE_SUBMITTED",
           content: Time.now.strftime("%D") },
          {name: "SCHOOL_NAME",
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
           {name: "REFERRAL_NAME",
           content: event.referral_name},
          {name: "EVENT_NAME",
           content: event.event_name},
           {name: "NUMBER_SENIORS",
           content: number_seniors},
          {name: "JUNIORS_ATTEND",
           content: juniors},
           {name: "NUMBER_JUNIORS",
           content: number_juniors},
          {name: "BLACK_TIE",
           content: black_tie},
          {name: "DATE",
           content: event.date.strftime("%D") },
          {name: "EMAIL",
           content: user.email},
          {name: "REP_FIRST_NAME",
           content: event.first_name},
          {name: "REP_LAST_NAME",
           content: event.last_name},
          {name: "TITLE",
           content: event.contact_title},
          {name: "REP_PHONE",
           content: event.contact_phone},
          {name: "PREF_ALS_LOCATION_NAME",
           content: location.store_name },
          {name: "PREF_ALS_LOCATION_ADDRESS",
           content: location.street_address},
          {name: "GROUP_CODE",
           content: event.group_code.number}
        ]
      }
      MANDRILL.messages.send_template 'school-fund-raising-for-education-submission', [], message
    end

    def prom_rep_program(event_params, event, user)
      location = Location.find event_params[:location_id]
      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ format_receipient_from_form(event_params, user)]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
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
      MANDRILL.messages.send_template 'prom-rep-program', [], message
    end
    
    def prom_rep_program_submission(event_params, event, user)

      location = Location.find event_params[:location_id]
      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [  { type: "to", name: location.store_name, email: location.email || "N/A"  },
                        # { type: "to", name: "Store Manager", email: location.manager_email || "N/A" },
                        # { type: "to", name: "Area Manager", email: location.area_manager_email || "N/A" },
                        { type: "cc", name: "Marketing", email: "marketing@alsformalwear.com" },
                        { type: "cc", name: "AM", email: "am@alsformalwear.com" }
        ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com"},
        to: recipients,
        global_merge_vars: [
          {name: "EVENT_NAME",
           content: event.event_name},
          {name: "DATE_SUBMITTED",
           content: Time.now.strftime("%D") },
          {name: "SCHOOL_NAME",
           content: event.orgname},
          {name: "MAILING_ADDRESS",
           content: event.street_address},
          {name: "CITY",
           content: event.city},
          {name: "STATE",
           content: event.state},
          {name: "ZIP",
           content: event.zip_code},
          {name: "SCHOOL_CITY",
           content: event.school_city},
          {name: "SCHOOL_STATE",
           content: event.school_state},
          {name: "SCHOOL_ZIP",
           content: event.school_zip_code},
          {name: "TAX_ID",
           content: event.tax_id},
          {name: "DATE",
           content: event.date},
          {name: "EMAIL",
           content: user.email},
           {name: "PHONE",
           content: user.phone_number || "Not Provided"},
          {name: "REP_FIRST_NAME",
           content: event.first_name},
          {name: "REP_LAST_NAME",
           content: event.last_name},
          {name: "TITLE",
           content: event.contact_title},
          {name: "REP_PHONE",
           content: event_params[:contact_phone] || user.phone_number || "Not Provided"},
          {name: "PREF_ALS_LOCATION_NAME",
           content: location.store_name },
          {name: "PREF_ALS_LOCATION_ADDRESS",
           content: location.street_address},
           {name: "SCHOOL_YEAR",
           content: event_params[:school_year]},
          {name: "GROUP_CODE",
           content: event.group_code.number}
        ]
      }
      MANDRILL.messages.send_template 'prom-rep-program-submission', [], message
    end

    def school_group_sales(school_group_sale_params)

      if Rails.env.development? || Rails.env.test?
        recipients = [ { type: 'to', name: "Al's @ V+V", email: 'ross@verbalplusvisual.com' } ]
      else
        recipients = [ { type: "to", name: "Group Sales", email: "GroupSales@alsformalwear.com" },
                       { type: "cc", name: "AM", email: "am@alsformalwear.com" }
        ]
      end
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com"},
        to: recipients,
        global_merge_vars: [
          {name: "DATE_SUBMITTED",
           content: Time.now.strftime("%D") },
          {name: "FIRST_NAME",
           content: school_group_sale_params[:first_name]},
          {name: "LAST_NAME",
           content: school_group_sale_params[:last_name] },
          {name: "CITY",
           content: school_group_sale_params[:city] },
          {name: "STATE",
           content: school_group_sale_params[:state] },
          {name: "ZIP",
           content: school_group_sale_params[:zip_code] },
          {name: "EMAIL",
           content: school_group_sale_params[:contact_email] },
          {name: "PHONE",
           content: school_group_sale_params[:contact_phone ] },
          {name: "BUDGET",
           content: school_group_sale_params[:budget] },
          {name: "NUM_UNIFORMS",
           content: school_group_sale_params[:number_uniforms] },
          {name: "DEADLINE",
           content: school_group_sale_params[:deadline] },
          {name: "SCHOOL_DISTRICT",
           content: school_group_sale_params[:school_district] },
          {name: "SCHOOL_NAME",
           content: school_group_sale_params[:orgname] },
          {name: "SCHOOL_TYPE",
           content: school_group_sale_params[:school_type] },
          {name: "SCHOOL_LEVEL",
           content: school_group_sale_params[:school_level] },
          {name: "TEACHER_NAME",
           content: school_group_sale_params[:teacher_name] },
          {name: "GROUP_TYPE",
           content: school_group_sale_params[:group_type] },
          {name: "GROUP_TYPE_IF_OTHER",
           content: school_group_sale_params[:group_type_explain] || "N/A" },
          {name: "UNIFORM_TYPE",
           content: school_group_sale_params[:uniform_type] },
          {name: "UNIFORM_IF_OTHER",
           content: school_group_sale_params[:uniform_explain] || "N/A" },
          {name: "SPECIAL_ACCESSORIES",
           content: school_group_sale_params[:accessories] || "N/A" },
          {name: "SPECIAL_NEEDS",
           content: school_group_sale_params[:special_needs] || "N/A" }
        ]  
      }    
      MANDRILL.messages.send_template 'school-group-sales-submission', [], message
    end

    private

    def format_receipient_user user
      { type: 'to', name: "#{user.first_name} #{user.last_name}".strip, email: user.email }
    end
    def format_receipient_from_form(params, user)
      { type: 'to', name: "#{params[:first_name]} #{params[:first_name]}".strip, email: user.email || params[:email] }
    end

  end
end







