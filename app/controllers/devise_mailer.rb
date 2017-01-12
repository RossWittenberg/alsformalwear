if defined?(ActionMailer)
  class DeviseMailer < Devise::Mailer

    include Devise::Controllers::UrlHelpers
    include Devise::Mailers::Helpers
    include Rails.application.routes.url_helpers
    include Spree.railtie_routes_url_helpers

    def confirmation_instructions(user, token, opts={})
      user.confirm
    end

    def reset_password_instructions(user, token, opts={})
      password_reset_url = "http://www.#{Spree::Store.current.url}/catalog/user/spree_user/password/edit?reset_password_token=#{token}"
      message = {
        headers: { "Reply-to": "notify@alsformalwear.com" },
        to: [ format_receipient_user(user) ],


        global_merge_vars: [
          { name: "PASSWORDRESETBUTTON",
            content: '<a class="mcnButton" title="RESET PASSWORD" href="'+password_reset_url+'" target="_blank" style="font-weight: bold;letter-spacing: normal;line-height: 100%;text-align: center;text-decoration: none;color: #FFFFFF;">RESET PASSWORD</a>'
          }
        ]
      }
      MANDRILL.messages.send_template 'reset-password', [], message
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


