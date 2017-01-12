Spree::Variant.class_eval do
  
  belongs_to :favorite

  has_attached_file :secondary_byt_image, 
	styles: { 
		thumbnail: '100x186',
		mobile:  '280x466',
		desktop: '400x666',
    product: '600x1000>'},
  	default_url: ""

  validates_attachment :secondary_byt_image,
    :content_type => { content_type: %w(image/jpeg image/jpg image/png image/gif) }

  has_attached_file :byt_image, 
	styles: { 
		thumbnail: '100x186',
		mobile:  '280x466',
		desktop: '400x666',
    product: '600x1000>'}, 
	
  default_url: "/assets/images/spree/frontend/noimage.png"
  


  validates_attachment :byt_image,
    :content_type => { content_type: %w(image/jpeg image/jpg image/png image/gif) }

  DEFAULTS_FOR_COMPLETE_THIS_LOOK = [] << Spree::Variant.find_by_sku("81") << Spree::Variant.find_by_sku("3225") << Spree::Variant.find_by_sku("7015")<< Spree::Variant.find_by_sku("6002")<< Spree::Variant.find_by_sku("4052")

  def designer_sort
    (self.designer == "Michael Kors" || self.designer == "michael kors") ? "aaa" : self.designer
  end

  def designer
    self.product.designer || "N/A"
  end

  def catalog_product_position
    self.product.catalog_position
  end

  def path
    "/catalog/products/#{self.product.slug}?variant_id=#{self.id}"
  end

  def requires_secondary_byt_image?
  	self.category_value == "Suits" || self.category_value == "Coat and Pants" || self.category_value == "Tuxedos"
  end

  def product_variants_for_select
    if self.images.present?
	    { src: self.images[0].attachment(:full), 
  	  	color: self.option_value("child_color"),
  	  	variant_id: self.id,
  	  	byt?: self.is_byt?,
        alt:  self.image_alt}
  	end  	
  end

  def image_alt
    if self.images.present?
      if self.images[0].alt.blank?
        return "#{self.product.designer.split.map(&:capitalize).join(' ')} #{self.product.name} #{self.category_value}"
      else 
        return "#{self.images[0].alt}"
      end
    end
  end

  def child_color 
  	child_opt_id = Spree::OptionType.find_by(name: "child_color").id
  	color = self.option_values.select { |ov| ov.option_type_id == child_opt_id }.first.name
  end  

  def parent_color 
    parent_opt_id = Spree::OptionType.find_by(name: "parent_color").id
    color = self.option_values.select { |ov| ov.option_type_id == parent_opt_id }.first.name
  end

  def product_family
  	self.product.family
  end

  def category_value
  	category = Spree::Taxon.find_by_name "Category"
  	category_values = self.product.taxons.select { |t| t.parent_id == category.id }.map(&:name)
  	category_value = category_values.delete_if { |e| e == "All"}
  	return category_value.first
  end

  def category_permalink
    category = Spree::Taxon.find_by_name "Category"
    category_values = self.product.taxons.select { |t| t.parent_id == category.id }.map(&:permalink)
    category_value = category_values.delete_if { |e| e == "All"}
    return category_value.first
  end

  def category_slug
    self.category_permalink.gsub("product-categories/", "")
  end

  def similar
  	similar_products = []
		
    taxon = Spree::Taxon.find_by_name self.category_value
    similar_products << Spree::Product.includes(:variants).in_taxon(taxon).uniq.map(&:variants).flatten.select { |v| v.option_values.include? Spree::OptionValue.find_by_name("#{self.parent_color}") }
    similar_products = similar_products.flatten.delete_if {|v| v == self }

    if similar_products.count >= 4
      return similar_products.shuffle.pop(4)
    else
      related_by_category = Spree::Variant.all.select { |v| v.category_value == self.category_value && v.is_master == false }.shuffle
      related_by_category = related_by_category.flatten.delete_if {|v| v == self }
      
      if related_by_category.count >= 4
        while similar_products.count < 4 do
          i = 0
          while i < related_by_category.count
            similar_products << related_by_category.pop
            i += 1
          end
        end
      else
        while similar_products.count < related_by_category.count do
          i = 0
          while i <= related_by_category.count
            similar_products << related_by_category.pop
            i += 1
          end
        end
      end
      return similar_products.shuffle.pop(4)
    end
  end

  def related
		related_by_color = Spree::Variant.includes(:option_values).select { |v| v.option_values.include? Spree::OptionValue.find_by_name("#{self.child_color}") }
		
		related_by_color.delete_if { |v| v.product.taxons.pluck(:name).flatten.include? category_value }
				
		related_by_family  = Spree::Variant.all.select { |v| v.product_family ==  self.product_family }.delete_if { |v| v == self }	
		
		related = related_by_color & related_by_family
		i = 0
	 	while related.count < 4 do
	 		related << DEFAULTS_FOR_COMPLETE_THIS_LOOK[i]
	 		i += 1
		end

		return related.compact.pop(4) 
  end

  def is_byt?
  	self.byt_image_file_size.present?
  end
	
  def filter_by_option(param_option_value, variants)
  	(self.option_values.include? param_option_value) && (variants.include?(self))
  end	

  def filter_by_property(param, variants)
  	(self.product.product_properties.any? { |pp| pp.value == param }) && (variants.include?(self))
  end

  def self.search_variants(keyword: 'nil')
    @results = []
    product_results = Spree::Product.search(name_cont: keyword).result.includes(:variants => :images).map(&:variants).flatten
    @results << product_results
    color_results = Spree::OptionValue.search(presentation_cont: keyword).result.includes(:variants => [:images]).map(&:variants).flatten
    @results << color_results
    property_results = Spree::ProductProperty.search(value_cont: keyword).result.includes(:product => {:variants => :images}).map(&:product).flatten.map(&:variants).flatten
    @results << property_results
    competitor_colors_results = CompetitorColor.search(name_cont: keyword)
    if competitor_colors_results.result.flatten.present?
      @parent_color = ParentColor.find competitor_colors_results.result.flatten[0].parent_color_id
      @results << Spree::OptionValue.search(presentation_cont: @parent_color.name).result.includes(:variants => [:images]).map(&:variants).flatten
    end
    taxons = Spree::Taxon.search(name_cont: keyword).result
    taxon_results = []

    if taxons.length > 0  
      taxons.each do |taxon|
      	taxon_results << Spree::Product.includes(:variants => :images).in_taxon(taxon).map(&:variants).flatten.uniq.compact
      end
    end  
    @results << taxon_results.flatten
    @results = @results.flatten.uniq.compact
  end

  def self.filter_variants( search_params, taxon, params )	
    @variants = []
    search_params.keys.each_with_index do |key, i|
      @param_matched_variants = []
      search_params[key].each_with_index do |param, j|
  		  if search_params.keys.any? {|p| OPTION_FILTERS.include?(p) } && search_params.keys.any? {|p| PROPERTY_FILTERS.include?(p) }
          if taxon.present?
            if COLORS.include?(param)
              param_option_value = Spree::OptionValue.find_by_name(param)
              variants = Spree::Product.in_taxon(taxon).order(featured: :desc, tuxedo: :desc).map(&:variants).flatten
  						color_matched_variants = Spree::Product.includes(:variants).in_taxon(taxon).uniq.map(&:variants).flatten.select { |v| v.filter_by_option(param_option_value, variants) }
  					else
              variants = Spree::Product.in_taxon(taxon).order(featured: :desc, tuxedo: :desc).map(&:variants).flatten
  						property_matched_variants = Spree::Product.includes(:variants).in_taxon(taxon).uniq.map(&:variants).flatten.select { |v| v.filter_by_property(param, variants) }
  					end	
  				else
  					if COLORS.include?(param)
              option_value = Spree::OptionValue.find_by_name(param)
  			  		color_matched_variants = Spree::Product.includes(:variants).map(&:variants).flatten.select { |v| v.option_values.include? option_value }
  		  		else
  		  			property_matched_variants = Spree::Product.includes(:variants).map(&:variants).flatten.select { |v| v.product.product_properties.any? { |pp| pp.value == param } }
  		  		end
  				end
  			elsif search_params.keys.any? {|p| PROPERTY_FILTERS.include?(p) }
  				if taxon
            variants = Spree::Product.in_taxon(taxon).order(featured: :desc, tuxedo: :desc).map(&:variants).flatten
  					property_matched_variants = Spree::Product.includes(:variants).in_taxon(taxon).map(&:variants).flatten.select { |v| v.filter_by_property(param, variants) }
  				else
  		  		property_matched_variants = Spree::Product.includes(:variants).map(&:variants).flatten.select do |v|
  		  		  v.product.product_properties.any? { |pp| pp.value == param }
  		  		end
  				end
  		  else
  		  	if taxon
            param_option_value = Spree::OptionValue.find_by_name(param)
            variants = Spree::Product.in_taxon(taxon).order(featured: :desc, tuxedo: :desc).map(&:variants).flatten          
  					color_matched_variants = Spree::Product.includes(:variants).order(featured: :desc, tuxedo: :desc).in_taxon(taxon).map(&:variants).flatten.select { |v| v.filter_by_option(param_option_value, variants) }
  				else
            option_value = Spree::OptionValue.find_by_name(param)
  		  		color_matched_variants = Spree::Product.includes(:variants).order(featured: :desc, tuxedo: :desc).map(&:variants).flatten.select { |v| v.option_values.include? option_value }
  				end 	
  		  end
        if j == 0  
          @param_matched_variants << color_matched_variants if color_matched_variants
          @param_matched_variants << property_matched_variants if property_matched_variants
        else
          if search_params[key].count == 1
            @param_matched_variants = @param_matched_variants.flatten & color_matched_variants if color_matched_variants
            @param_matched_variants = @param_matched_variants.flatten & property_matched_variants if property_matched_variants
          else
            @param_matched_variants << color_matched_variants if color_matched_variants
            @param_matched_variants << property_matched_variants if property_matched_variants
          end
        end
      end
      if i == 0
		  	@variants << @param_matched_variants.flatten
		  else
		  	@variants = @variants.flatten & @param_matched_variants.flatten
		  end
	  end

	  if search_params[:keyword].present?
	  	@variants << Spree::Variant.search_variants(keyword: search_params[:keyword])
		end

		@variants = @variants.flatten.uniq.compact
  	return @variants
  end	

  def self.check_if_child_color_exists(color)
    colors_to_delete = []
    self.includes(:option_values).each do |variant|
      variant.option_values.each do |ov|
        if ov.name == color
          colors_to_delete << ov
        end
      end
    end
    colors_to_delete.empty? ? color : false
  end


end
