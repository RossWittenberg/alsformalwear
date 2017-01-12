Spree::TaxonsController.class_eval do

  respond_to :html, :json
  
  def show
    @taxon = Spree::Taxon.find_by_permalink!(params[:id])

    return unless @taxon
  
    page = (params && params[:page] )|| 1
    per_page = (params && params[:per_page] )|| 12

    if params[:id] == "product-categories"
      redirect_to "/catalog/products"
    end

    if params[:search]
      @variants =  Spree::Variant.includes(:product).filter_variants(params[:search], @taxon, params).flatten.sort_by{ |v| [v.product.catalog_position, v.designer_sort] }
      @variants_count = @variants.flatten.count
      @variants = Kaminari.paginate_array(  @variants.flatten  ).page(page).per(per_page) unless @variants.blank?
    else
      searcher_params = params.clone
      searcher_params.delete :page if params[:page].present?
      @searcher = build_searcher(searcher_params.merge(include_images: true))
      if params[:id] == "product-categories/all"
        @variants = @searcher.retrieve_products.in_taxon(@taxon).map { |p| p.variants.includes(:product) }.flatten.sort_by{ |v| [v.product.catalog_position, v.designer_sort] }
        else
        @variants = @searcher.retrieve_products.in_taxon(@taxon).map { |p| p.variants.includes(:product) }.flatten.sort_by(&:designer_sort)
      end
      @variants_count = @variants.flatten.count
      @variants = Kaminari.paginate_array(  @variants.flatten  ).page(page).per(per_page) unless @variants.blank?
    end
    respond_to do |format|
      format.json do
        render json: @variants, each_serializer: Spree::VariantSerializer, root: "variants", meta: { total_records: @variants_count }
      end
      format.html do 
        @taxonomies = Spree::Taxonomy.includes(root: :children)
        unless @variants.blank?
          @variants = Kaminari.paginate_array( @variants ).page(page).per(per_page)
        end 
      end
    end
  end
end

# sorting:

# @products = @products.send(sorting_scope)


  # def sorting_param
  #   params[:sorting].try(:to_sym) || default_sorting
  # end

  private

  # def sorting_scope
  #   allowed_sortings.include?(sorting_param) ? sorting_param : default_sorting
  # end

  # def default_sorting
  #   :ascend_by_updated_at
  # end

  # def allowed_sortings
  #   [:descend_by_master_price, :ascend_by_master_price, :ascend_by_updated_at]
  # end