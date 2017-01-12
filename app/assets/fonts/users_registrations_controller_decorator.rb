Spree::UserRegistrationsController.class_eval do
  def new
    build_resource({})
    set_minimum_password_length
    yield resource if block_given?
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    if resource.valid? && resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          @success_message = "Success! Account created."
          flash[:sign_up_success] = @success_message
          sign_up(resource_name, resource)
          if params[:spree_user] && params[:spree_user][:after_login_redirect].present?
            respond_with resource, location: "/#{params[:spree_user][:after_login_redirect]}"
          else
            yield resource if block_given?
            respond_with resource, location: after_sign_in_path_for(resource)
          end
        else
          @success_message = "Success! Account created."
          flash[:sign_up_success] = @success_message
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    else
      @errors = resource.errors.full_messages.uniq.delete_if { |e| e == "Password is too short (minimum is 6 characters)" }
      flash[:sign_up_errors] = @errors
      redirect_to "/catalog/login"
    end
  end

end
