class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def after_sign_in_path_for(user)
    request.env['omniauth.origin'] || spree.account_path
  end

  def after_sign_up_path_for(resource)
    request.env['omniauth.origin'] || spree.account_path
    
  end

  def after_inactive_sign_up_path_for(resource)
    spree.account_path
  end

  def after_sign_out_path_for(resource_or_scope)
    "/"
  end
  
end
