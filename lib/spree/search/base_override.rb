Spree::Core::Search::Base.class_eval do 

  def retrieve_products
    @products = get_base_scope

    unless Spree::Config.show_products_without_price
      @products = @products.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => current_currency)
    end
    return @products 
  end

  protected
  def get_base_scope
    base_scope = Spree::Product.active
    base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
    base_scope = get_products_conditions_for(base_scope, keywords)
    base_scope = add_search_scopes(base_scope)
    base_scope = add_eagerload_scopes(base_scope)
    base_scope
  end

end