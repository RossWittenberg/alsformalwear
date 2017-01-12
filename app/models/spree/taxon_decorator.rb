Spree::Taxon.class_eval do

	def applicable_filters(parent_color: nil )
    fs = []	
    # fs << Spree::Core::ProductFilters.child_color_any(parent_color) 
    # fs << Spree::Core::ProductFilters.parent_and_children_colors_any(taxon: self) 

    fs << Spree::Core::ProductFilters.parent_color_any(taxon: self)
    fs << Spree::Core::ProductFilters.child_colors_any_by_taxon(taxon: self) 

    fs << Spree::Core::ProductFilters.designer_any(taxon: self)
    fs << Spree::Core::ProductFilters.fit_any if has_fit?
# coat optiopns 
    fs << Spree::Core::ProductFilters.lapel_any if coats?
    fs << Spree::Core::ProductFilters.buttons_any if coats?
# styles
    fs << Spree::Core::ProductFilters.coat_style_any if coats?
    fs << Spree::Core::ProductFilters.pant_style_any if pants?
    fs << Spree::Core::ProductFilters.shirt_style_any if shirts?
    fs << Spree::Core::ProductFilters.tie_style_any if ties?
    fs << Spree::Core::ProductFilters.vest_style_any if vests?
    fs
  end


  def simple_name
    self.name.downcase.gsub(' ', '_')
  end

  ALL_TAXONS = Spree::Taxon.all.map(&:simple_name)

  ALL_TAXONS.each do |taxon|
    define_method("#{taxon}?") do
      self.simple_name == taxon ? true : false
    end
  end

  def coats?
    ["Suits", "Jackets", "Tuxedos", "Coats and Pants"].include? self.name
  end

  def has_fit?
    ["Suits", "Jackets", "Tuxedos", "Pants", "Coats and Pants"].include? self.name
  end

  def self.set_positions
    self.all.each do |taxon|
      case taxon.name
      when "Tuxedos"
        taxon.update_attributes({position: 1})
      when "Suits"
        taxon.update_attributes({position: 2})
      when "Vests or Cummerbunds"
        taxon.update_attributes({position: 3})
      when "Vests"
        taxon.update_attributes({position: 4})
      when "Cummerbunds"
        taxon.update_attributes({position: 4})
      when "Shirts"
        taxon.update_attributes({position: 5})
      when "Ties"
        taxon.update_attributes({position: 6})
      when "Shoes"
        taxon.update_attributes({position: 7})
      when "Accessory Packages"
        taxon.update_attributes({position: 8})
      when "Studs & Links"
        taxon.update_attributes({position: 9})
      when "Pants"
        taxon.update_attributes({position: 10})
      end
      if (taxon.position == 0) || (taxon.position == nil)
        taxon.update_attributes({position: 100})
      end 
    end
  end
#   def applicable_filters_without_colors
#     fs = [] 
#     fs << Spree::Core::ProductFilters.designer_any
#     fs << Spree::Core::ProductFilters.fit_any if has_fit?
# # coat optiopns 
#     fs << Spree::Core::ProductFilters.lapel_any if coats?
#     fs << Spree::Core::ProductFilters.buttons_any if coats?
# # styles
#     fs << Spree::Core::ProductFilters.coat_style_any if coats?
#     fs << Spree::Core::ProductFilters.pant_style_any if pants?
#     fs << Spree::Core::ProductFilters.shirt_style_any if shirts?
#     fs << Spree::Core::ProductFilters.tie_style_any if ties?
#     fs << Spree::Core::ProductFilters.vest_style_any if vests?

#     fs
#   end
end
