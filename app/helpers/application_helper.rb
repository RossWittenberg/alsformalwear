module ApplicationHelper

	def set_filters(taxon: nil)
		if taxon
			if params[:search].present? && params[:search]["parent-color"].present?
				filters = taxon.applicable_filters( parent_color: params[:search]["parent-color"] )
				filters = filters.flatten.delete_if { |h| h[:name] == "parent-color" }
			else
				taxon.applicable_filters
			end
		else
			if params[:search].present? && params[:search]["parent-color"].present?
				[Spree::Core::ProductFilters.child_color_any(params[:search]["parent-color"])]
			else
				[Spree::Core::ProductFilters.parent_color_any, Spree::Core::ProductFilters.designer_any ]
			end	
		end
	end

	def set_filters_without_color(taxon: nil)
		if taxon
			taxon.applicable_filters_without_colors
		else
			Spree::Core::ProductFilters.designer_any
		end
	end

end
 
