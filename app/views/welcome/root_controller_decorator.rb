Spree::Admin::RootController.class_eval do
  private

  def admin_root_redirect_path
    if can?(:display, Spree::Order) && can?(:admin, Spree::Order)
      if spree_current_user.district_manager?  
        spree.admin_locations_path
      else
        spree.admin_orders_path
      end
    elsif can?(:admin, :dashboards) && can?(:home, :dashboards)
      spree.home_admin_dashboards_path
    else
      # Invoke the unauthorized redirect, which will ideally go to the login controller
      # of the users chosen authorization implimentation. For devise this is /admin/login.
      #
      # This is done so devise redirects back to this controller, instead of the one specified
      # below, so this controller can use the user that is required for the path to
      # be calculated.
      raise CanCan::AccessDenied
    end
  end
end