Spree::ProductsController.class_eval do
	respond_to :html, :json

  helper_method :sorting_param

  include Spree
  include DeviseHelper

  def index
    @user = spree_current_user
    if params[:search]
      @variants = Spree::Variant.includes(:product).filter_variants(params[:search], nil, params)
    else
      searcher_params = params.clone
      searcher_params.delete :page
      @searcher = build_searcher(searcher_params.merge(include_images: true))
      @variants = @searcher.retrieve_products.order(featured: :desc, tuxedo: :desc).map { |p| p.variants.includes(:product) }.flatten
    end
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    unless @variants.blank?
      @variants = Kaminari.paginate_array( @variants ).page(params[:page] || 1 ).per(12)
    end 
    @custom_meta_tags = true
  end

  def show
    @variants = @product.variants_including_master.active(current_currency).includes([:option_values, :images])
    @product_properties = @product.product_properties.includes(:property)
    @taxon = Spree::Taxon.find(params[:taxon_id]) if params[:taxon_id]
    
    @user = spree_current_user

    if @user
      @user_favorites_array = @user.favorites.pluck(:variant_id).uniq
    end

    if params[:variant_id]
      @variant = Spree::Variant.find params[:variant_id]
      @product_variants_for_select = @variants.map(&:product_variants_for_select).uniq.compact
      @similar = @variant.similar
      @related = @variant.related
    end
    @custom_meta_tags = true
  end




# sorting
  # @products = @products.send(sorting_scope)

  # def sorting_param
  #   params[:sorting].try(:to_sym) || default_sorting
  # end

  # private

  # def sorting_scope
  #   allowed_sortings.include?(sorting_param) ? sorting_param : default_sorting
  # end

  # def default_sorting
  #   :ascend_by_updated_at
  # end

  # def allowed_sortings
  #   [:descend_by_master_price, :ascend_by_master_price, :ascend_by_updated_at]
  # end
  
end