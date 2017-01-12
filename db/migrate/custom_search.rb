module Spree
  class CustomSearch < Spree::Core::Search::Base

    protected
    
    def add_search_scopes(base_scope)
      statement = nil
      search.each do |property_name, property_values|
        name = property_name.gsub("_any", "").gsub("selective_","").capitalize
        property = Spree::Property.find_by_name(name)
        next unless property

        binding.pry

        substatement = product_property[:property_id].eq(property.id).and(product_property[:value].eq(property_values.first))
        #substatement = Spree::Product.with_property_value(name, property_values.first)
        property_values[1..-1].each do |pv|
          substatement = substatement.or product_property[:value].eq(pv)
          #substatement = substatement.or Spree::Product.with_property_value(name, pv)
        end
        tail = product[:id].in(Spree::ProductProperty.select(:product_id).where(substatement).map(&:product_id))
        #ids = Spree::ProductProperty.select(:product_id).where(substatement).map(&:product_id)
        #tail = product[:id].in(ids)
        statement = statement.nil? ? tail : statement.and(tail)
      end if search
      statement ? base_scope.where(statement) : base_scope
    end

    def prepare(params)
      super
      @properties[:product] = Spree::Product.arel_table
      @properties[:product_property] = Spree::ProductProperty.arel_table
    end
  
  end
end