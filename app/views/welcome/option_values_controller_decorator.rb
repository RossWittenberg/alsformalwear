Spree::Admin::OptionValuesController.class_eval do
  def destroy
    option_value = Spree::OptionValue.find(params[:id])
    option_value.destroy
    flash[:success] = flash_message_for(option_value, :successfully_updated)
    redirect_to "/catalog/admin/option_types/#{option_value.option_type_id}/edit"
	end
end