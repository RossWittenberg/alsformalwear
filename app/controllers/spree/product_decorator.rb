Spree::Product.class_eval do

  def set_family
    if self.taxons.include?(Spree::Taxon.find_by name: "Tuxedos")
      self.update_attributes({family: "Tuxedos"})
    elsif self.taxons.include?(Spree::Taxon.find_by name: "Suits")
      self.update_attributes({family: "Suits"})
    elsif self.taxons.include?((Spree::Taxon.find_by_name "Accessory Packages")) || self.taxons.include?((Spree::Taxon.find_by_name "Studs & Links"))
      self.update_attributes({family: "Accessories"})
    elsif self.taxons.include?(Spree::Taxon.find_by name: "Shirts")
      self.update_attributes({family: "Shirts"})
    elsif self.taxons.include?(Spree::Taxon.find_by name: "Ties")
      self.update_attributes({family: "Ties"})
    elsif self.taxons.include?(Spree::Taxon.find_by name: "Shoes")
      self.update_attributes({family: "Shoes"})
    elsif self.taxons.include?(Spree::Taxon.find_by name: "Pants")
      self.update_attributes({family: "Pants"})
    elsif self.taxons.include?((Spree::Taxon.find_by_name "Vests")) || self.taxons.include?((Spree::Taxon.find_by_name "Cummerbunds")) || self.taxons.include?((Spree::Taxon.find_by_name "Vests or Cummerbunds"))
      self.update_attributes({family: "Vests or Cummerbunds"})
    end
  end

  def self.tuxedos
    self.in_taxon(Spree::Taxon.find_by_name "Tuxedos")
  end

  def self.suits
    self.in_taxon(Spree::Taxon.find_by_name "Suits")
  end

  def self.accessories
    accessories = []
    accessories << self.in_taxon(Spree::Taxon.find_by_name "Accessory Packages") << self.in_taxon(Spree::Taxon.find_by_name "Studs & Links")
  end

  def self.shirts
    self.in_taxon(Spree::Taxon.find_by_name "Shirts")
  end
  
  def self.ties
    self.in_taxon(Spree::Taxon.find_by_name "Ties")
  end

  def self.shoes
    self.in_taxon(Spree::Taxon.find_by_name "Shoes")
  end

  def self.pants
    self.in_taxon(Spree::Taxon.find_by_name "Pants")
  end


  def self.vests
    self.in_taxon(Spree::Taxon.find_by_name "Vests")
  end

  def self.cummerbunds
    self.in_taxon(Spree::Taxon.find_by_name "Cummerbunds")
  end

  def self.vests_and_cummerbunds
    vests_and_cummerbunds = []
    vests_and_cummerbunds << self.in_taxon(Spree::Taxon.find_by_name "Vests or Cummerbunds") << self.in_taxon(Spree::Taxon.find_by_name "Vests") << self.in_taxon(Spree::Taxon.find_by_name "Cummerbunds")
  end

  add_search_scope :in_taxon do |taxon|
    includes(:classifications).
    where("spree_products_taxons.taxon_id" => taxon.self_and_descendants.pluck(:id)).
    order(Spree::Classification.arel_table[:position].asc)
  end

  def family_taxon
    Spree::Taxon.find_by_name self.family
  end

  def catalog_position
    if self.family_taxon
      return self.family_taxon.position
    else
      return 100
    end
  end

  def update_as_tux
    if self.taxons.include?(Spree::Taxon.find_by name: "Tuxedos")
      self.update_attribute(:tuxedo, true)
      self.save
    end
  end

  def designer
    self.property("designer") || " "
  end

  def no_decimal_price
  	"$#{self.price.floor}"
  end

  def self.getprods(params)
    #get taxon_id from permalink
    taxonid = params[:id].blank? ? nil : Taxon.find_by_permalink!(params[:id]).id
    #keywords for paging
    	
    keywords = params[:keywords]
    per_page = params[:per_page].to_i
    per_page = per_page > 0 ? per_page : Spree::Config[:products_per_page]
    page = (params[:page].to_i <= 0) ? 1 : params[:page].to_i

      sql = "SELECT p.* FROM spree_products p INNER JOIN spree_products_taxons t ON t.product_id = p.id INNER JOIN spree_taxons ON spree_taxons.id = t.taxon_id WHERE spree_taxons.id IN (#{taxonid}) "
      params[:search].blank? ? nil : params[:search].each{ |p| 	    		
      tid = Spree::Property.find_by_name(p.first.gsub("_any", "")).id
      sql += "AND p.id IN (SELECT c.product_id FROM spree_product_properties c where c.property_id = #{tid} "

      # allows multiple values for property_id
      p.second.each_with_index{ |s,i|
        if i == 0 
          sql += "AND c.value = '#{s.to_s}' "
        else
          sql += "OR c.value = '#{s.to_s}' "
        end
      }
      sql += ")"
    }
    curr_page = keywords ? 1 : page
    products = Spree::Product.active
    products = products.find_by_sql(sql)
    #products = products.page(curr_page).per(per_page)
  end
end