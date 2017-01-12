class Spree::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook # Facebook never provides a phone number. —JC
    uid = request.env["omniauth.auth"][:uid]

    email_address = request.env["omniauth.auth"][:info][:email]
    first_name    = request.env["omniauth.auth"][:info][:first_name]
    last_name     = request.env["omniauth.auth"][:info][:last_name]

    sign_up_or_sign_in email_address, 'facebook', uid, { first_name: first_name,
                                                         last_name:  last_name }
  end

  def gplus # Google+ never provides a phone number. —JC
    uid = request.env["omniauth.auth"][:uid]

    email_address = request.env["omniauth.auth"][:info][:email]
    first_name    = request.env["omniauth.auth"][:info][:first_name]
    last_name     = request.env["omniauth.auth"][:info][:last_name]
    
    sign_up_or_sign_in email_address, 'gplus', uid, { first_name: first_name,
                                                      last_name:  last_name }
  end

  def twitter
    uid = request.env["omniauth.auth"][:uid]

    email_address = request.env["omniauth.auth"][:info][:email]
    first_name    = request.env["omniauth.auth"][:info][:name].split(/ /)[0]
    last_name     = request.env["omniauth.auth"][:info][:name].sub(first_name + ' ', '')

    sign_up_or_sign_in email_address, 'twitter', uid, { first_name: first_name,
                                                        last_name:  last_name }
  end

  def failure
    render text: "login or signup failure; possibly unauthorized", status: 401
    raise params.to_s
  end

private

  def placeholder_password_if_omniauth_only
    Devise.friendly_token[0,20]
  end

  def new_attributes user, additional_attributes
    user_empty_attributes = user.attributes.reject { |_,value| value.present? }
    additional_attributes.select do |attr,_|
      user_empty_attributes.include?(attr) && !user_empty_attributes[attr].present?
    end
  end

  def find_or_create_user_by_email_address email_address, additional_attributes = {}

    additional_attributes.stringify_keys!
    additional_attributes.select! { |_,value| value.present? }

    if preexisting_user = Spree::User.where(email: email_address).first
      user = preexisting_user

      if (staged_updates = new_attributes user, additional_attributes).present?
        user.update_attributes! staged_updates # whitelisting in model can prevent mass-assignment. —JC
      end

      user
    else
      new_user_required_attributes = {
        email:    email_address,
        password: placeholder_password_if_omniauth_only
      }
      new_user_attributes = new_user_required_attributes.merge additional_attributes
      new_user = Spree::User.new new_user_attributes
      new_user.save!

      user = new_user
    end

    user.confirm # if the provider says the customer is who he says, good enough for me. —JC
    user
  end

  def find_or_create_identity user, provider_name, uid
    if preexisting_identity = user.identities.where(provider: provider_name).first
      preexisting_identity
    else
      new_identity = user.identities.new(
        provider: provider_name,
        uid:      uid)
      new_identity.save!
      new_identity
    end
  end

  def sign_up_or_sign_in email_address, provider_name, uid, additional_attributes = {}
    ActiveRecord::Base.transaction do
      user = find_or_create_user_by_email_address email_address, additional_attributes
      find_or_create_identity user, provider_name, uid
      
      sign_in_and_redirect user
      set_flash_message(:notice, :success, :kind => "Via #{provider_name.humanize}, logged in or signed up successfully.")
    end
  end
end
