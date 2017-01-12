Spree::ProductsHelper.module_eval do
    
  def cache_key_for_products
    count = @products.count
    first_id = @products.first.id
    sorting = params[:sorting]
    "#{I18n.locale}/#{current_currency}/spree/products/all-#{params[:page]}-#{first_id}-#{sorting}-#{count}"
  end

  def current_sorting?(key)
    sorting_param == key.to_sym
  end

end