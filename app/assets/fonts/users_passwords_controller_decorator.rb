Spree::UserPasswordsController.class_eval do
  
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
    	@success_message = "An email has been sent to #{resource.email} with instructions to reset your password."
      flash[:password_reset_success] = @success_message
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  protected
  def after_resetting_password_path_for(resource)
    @success_message = "Your password has been updated."
    flash[:sign_up_success] = @success_message
    spree.account_path
  end
end

