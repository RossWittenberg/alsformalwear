Spree::UserSessionsController.class_eval do
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    if params[:spree_user] && params[:spree_user][:after_login_redirect].present?
    	respond_with resource, location: "/#{params[:spree_user][:after_login_redirect]}"
	  else
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  def failure   
    warden.custom_failure!
    flash[:errors] = "Your username and password do not match. Please try again."
    redirect_to "/catalog/login"
  end

  protected

  def auth_options
    {:scope => resource_name, :recall => "#{controller_path}#failure"}
  end

  def after_sign_up_path_for(resource)
    signed_in_root_path(resource)
  end

  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

end