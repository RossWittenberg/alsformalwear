Spree::UserConfirmationsController.class_eval do

  def show  	
  	self.resource = resource_class.confirm_by_token(params[:confirmation_token])
	  yield resource if block_given?
    if resource.errors.empty?
      @success_message = "Congratulations! You have successfully confirmed your email address."
      flash[:sign_up_success] = @success_message
      sign_in(resource_name, resource)
      redirect_to after_sign_in_path_for(resource)
    else
    	@errors = "Looks like you may have already confirmed this account. Please try signing in again."
      flash[:sign_up_errors] = @errors
      redirect_to after_sign_out_path_for(resource)
    end
  end

end