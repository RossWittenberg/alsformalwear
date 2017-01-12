module Spree
  module Core

    # THIS FILE SHOULD BE OVER-RIDDEN IN YOUR SITE EXTENSION!
    #   the exact code probably won't be useful, though you're welcome to modify and reuse
    #   the current contents are mainly for testing and documentation

    # To override this file...
    #   1) Make a copy of it in your sites local /lib/spree folder
    #   2) Add it to the config load path, or require it in an initializer, e.g...
    #
    #      # config/initializers/spree.rb
    #      require 'spree/core/product_filters'
    #

    # set up some basic filters for use with products
    #
    # Each filter has two parts
    #  * a parametrized named scope which expects a list of labels
    #  * an object which describes/defines the filter
    #
    # The filter description has three components
    #  * a name, for displaying on pages
    #  * a named scope which will 'execute' the filter
    #  * a mapping of presentation labels to the relevant condition (in the context of the named scope)
    #  * an optional list of labels and values (for use with object selection - see taxons examples below)
    #
    # The named scopes here have a suffix '_any', following Ransack's convention for a
    # scope which returns results which match any of the inputs. This is purely a convention,
    # but might be a useful reminder.
    #
    # When creating a form, the name of the checkbox group for a filter F should be
    # the name of F's scope with [] appended, eg "price_range_any[]", and for
    # each label you should have a checkbox with the label as its value. On submission,
    # Rails will send the action a hash containing (among other things) an array named
    # after the scope whose values are the active labels.
    #
    # Ransack will then convert this array to a call to the named scope with the array
    # contents, and the named scope will build a query with the disjunction of the conditions
    # relating to the labels, all relative to the scope's context.
    #
    # The details of how/when filters are used is a detail for specific models (eg products
    # or taxons), eg see the taxon model/controller.

    # See specific filters below for concrete examples.
    module ProductFilters

    def ProductFilters.option_with_values(option_scope, option, values)
      # get values IDs for Option with name {@option} and value-names in {@values} for use in SQL below
      
      option_values = Spree::OptionValue.where(:presentation => [values].flatten).joins(:option_type).where(OptionType.table_name => {:name => option}).pluck("#{OptionValue.table_name}.id")
      return option_scope if option_values.empty?
      option_scope = option_scope.where("#{Product.table_name}.id in (select product_id from #{Variant.table_name} v left join spree_option_values_variants ov on ov.variant_id = v.id where ov.option_value_id in (?))", option_values)
      option_scope
    end

    # option scope
    Spree::Product.scope :option_any,
     lambda { |*opts|
       option_scope = Spree::Product.includes(:variants_including_master)

       opts.map { |opt|
         option_scope = option_with_values(option_scope, *opt)
       }
       option_scope
      }

    # color options
    def ProductFilters.child_colors_any_by_taxon(taxon: "all")
    
      if taxon == "all"
        child_colors = Spree::OptionValue.where(:option_type_id => Spree::OptionType.find_by_name("child_color")).order("position").compact.uniq
      else

        # parent_opt_id = Spree::OptionType.find_by(name: "parent_color").id
        # parent_colors = taxon.products.map(&:variants).flatten.map(&:option_values).flatten.select { |ov| ov.option_type_id == parent_opt_id }.uniq
        
        child_opt_id = Spree::OptionType.find_by(name: "child_color").id
        child_colors = taxon.products.map(&:variants).flatten.map(&:option_values).flatten.select { |ov| ov.option_type_id == child_opt_id }.compact.uniq
        
      end

        labels = child_colors.map { |label| [label.presentation.titleize, label.name] }
        {
          :name => "child-color",
          :scope => :option_any,
          :conds => nil,
          :option => 'child_color',
          :class => "child-color", 
          :labels => labels
        }

        # color_filters = {}
        # parent_colors.each do |pc|
        #   color_filters[pc.name] = []
        #   child_colors.each do |cc|
        #     if COLOR_PAIRS[pc.name].include? cc.name
        #       color_filters[pc.name] << cc.name
        #     end
        #   end
        # end
        # return color_filters
        
    end


    def ProductFilters.parent_color_any(taxon: "all")
      if taxon == "all"
        parent_colors = Spree::OptionValue.where(:option_type_id => Spree::OptionType.find_by_name("parent_color")).order("position").compact.uniq
      else
        opt = Spree::OptionType.find_by(name: "parent_color").id
        parent_colors = taxon.products.map(&:variants).flatten.map(&:option_values).flatten.select { |ov| ov.option_type_id == opt }.uniq
      end
      labels = parent_colors.map { |label| [label.presentation, label.name] }
      {
        :name => "parent-color",
        :scope => :option_any,
        :conds => nil,
        :option => 'parent_color',
        :class => "parent-color", 
        :labels => labels
      }

    end
    def ProductFilters.child_color_any( parent_color )
      child_colors = Spree::OptionValue.where(:option_type_id => Spree::OptionType.find_by_name("child_color")).where(name: COLOR_PAIRS[parent_color]).order("position").compact.uniq
      labels = child_colors.map { |label| [label.presentation, label.name] }

      {
        :name => "child-color",
        :scope => :option_any,
        :conds => nil,
        :option => 'child_color',
        :class => "child-color", 
        :labels => labels
      }
    end

    def ProductFilters.designer_any(taxon: "all")
      designer_property = Spree::Property.find_by(name: 'designer')
      if taxon == "all"
        designers = designer_property ? Spree::ProductProperty.where(property_id: designer_property.id).pluck(:value).uniq.map(&:to_s) : []
      else 
        designers = taxon.products.map { |p| p.property("designer") }.flatten.compact.uniq
      end
      labels = designers.reject(&:empty?).map { |label| [label.titleize, label.downcase] }.sort
      michael_kors = [ "Michael Kors","michael kors"]
      if labels.include? michael_kors
        michael_kors_index = labels.index(michael_kors)
        labels = labels.insert(0, labels.delete_at(michael_kors_index))
      end

      {
        :name => "designer",
        :scope => :option_any,
        :conds => nil,
        :option => 'designer',
        :class => "designer", 
        :labels => labels
      }
    end

    def ProductFilters.lapel_any
      lapel_property = Spree::Property.find_by(name: 'lapel')
      lapels = lapel_property ? Spree::ProductProperty.where(property_id: lapel_property.id).pluck(:value).uniq.map(&:to_s) : []
      labels = lapels.reject(&:empty?).map { |label| [label.titleize, label.downcase] }.sort

      {
        :name => "lapel",
        :scope => :option_any,
        :conds => nil,
        :option => 'lapel',
        :class => "lapel", 
        :labels => labels
      }
    end

    def ProductFilters.fit_any
      fit_property = Spree::Property.find_by(name: 'fit')
      fits = fit_property ? Spree::ProductProperty.where(property_id: fit_property.id).pluck(:value).uniq.map(&:to_s) : []
      labels = fits.reject(&:empty?).map { |label| [label.titleize, label.downcase] }

      {
        :name => "fit",
        :scope => :option_any,
        :conds => nil,
        :option => 'fit',
        :class => "fit", 
        :labels => labels
      }
    end

    def ProductFilters.buttons_any
      buttons_property = Spree::Property.find_by(name: 'buttons')
      buttonss = buttons_property ? Spree::ProductProperty.where(property_id: buttons_property.id).pluck(:value).uniq.map(&:to_s) : []
      labels = buttonss.reject(&:empty?).map { |label| [label.titleize, label.downcase] }.sort

      {
        :name => "buttons",
        :scope => :option_any,
        :conds => nil,
        :option => 'buttons',
        :class => "buttons", 
        :labels => labels
      }
    end

    def ProductFilters.coat_style_any
      coat_style_property = Spree::Property.find_by(name: 'coat_style')
      coat_styles = coat_style_property ? Spree::ProductProperty.where(property_id: coat_style_property.id).pluck(:value).uniq.map(&:to_s) : []
      labels = coat_styles.reject(&:empty?).map { |label| [label.titleize, label.downcase] }.sort

      {
        :name => "coat-style",
        :scope => :option_any,
        :conds => nil,
        :option => 'coat_style',
        :class => "coat-style", 
        :labels => labels
      }
    end

    def ProductFilters.pant_style_any
      pant_style_property = Spree::Property.find_by(name: 'pant_style')
      pant_styles = pant_style_property ? Spree::ProductProperty.where(property_id: pant_style_property.id).pluck(:value).uniq.map(&:to_s) : []
      labels = pant_styles.reject(&:empty?).map { |label| [label.titleize, label.downcase] }.sort

      {
        :name => "pant-style",
        :scope => :option_any,
        :conds => nil,
        :option => 'pant_style',
        :class => "pant-style", 
        :labels => labels
      }
    end

    def ProductFilters.shirt_style_any
      shirt_style_property = Spree::Property.find_by(name: 'shirt_style')
      shirt_styles = shirt_style_property ? Spree::ProductProperty.where(property_id: shirt_style_property.id).pluck(:value).uniq.map(&:to_s) : []
      labels = shirt_styles.reject(&:empty?).map { |label| [label.titleize, label.downcase] }.uniq.sort

      {
        :name => "shirt-style",
        :scope => :option_any,
        :conds => nil,
        :option => 'shirt_style',
        :class => "shirt-style", 
        :labels => labels
      }
    end

    def ProductFilters.tie_style_any
      tie_style_property = Spree::Property.find_by(name: 'tie_style')
      tie_styles = tie_style_property ? Spree::ProductProperty.where(property_id: tie_style_property.id).pluck(:value).uniq.map(&:to_s) : []
      labels = tie_styles.reject(&:empty?).map { |label| [label.titleize, label.downcase] }.uniq.sort

      {
        :name => "tie-style",
        :scope => :option_any,
        :conds => nil,
        :option => 'tie_style',
        :class => "tie-style", 
        :labels => labels
      }
    end       

    def ProductFilters.vest_style_any
      vest_style_property = Spree::Property.find_by(name: 'vest_style')
      vest_styles = vest_style_property ? Spree::ProductProperty.where(property_id: vest_style_property.id).pluck(:value).uniq.map(&:to_s) : []
      labels = vest_styles.reject(&:empty?).map { |label| [label.titleize, label.downcase] }

      {
        :name => "vest-style",
        :scope => :option_any,
        :conds => nil,
        :option => 'vest_style',
        :class => "vest-style", 
        :labels => labels
      }
    end     
     # def ProductFilters.selective_brand_filter(taxon = nil)
     #   taxon ||= Spree::Taxonomy.first.root
     #   brand_property = Spree::Property.find_by(name: 'Brand')
     #   scope = Spree::ProductProperty.where(property: brand_property).
     #     joins(product: :taxons).
     #     where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
     #   brands = scope.pluck(:value).uniq
     #   {
     #     name:   'Designer',
     #     scope:  :selective_brand_any,
     #     labels: brands.sort.map { |k| [k, k] }
     #   }
     # end



      # Spree::Product.add_search_scope :parent_color_any do |*opts|
      #   conds = opts.map {|o| ProductFilters.color_filter[:conds][o]}.reject { |c| c.nil? }
      #   scope = conds.shift
      #   conds.each do |new_scope|
      #     scope = scope.or(new_scope)
      #   end
      #   # Spree::Product.with_property('Parent Color').where(scope)
      #   Spree::Variant.all.select { |v| v.option_values.where("option_values.name = ?", "Parent Color" ) }.collect { |v| v.product }.uniq.where(scope)

      # end

      # def ProductFilters.parent_color_filter
        

      #   parent_color_property = Spree::Property.find_by(name: 'Parent Color')
      #   parent_color = parent_color_property ? Spree::ProductProperty.where(property_id: parent_color_property.id).pluck(:value).uniq.map(&:to_s) : []
      #   pp = Spree::ProductProperty.arel_table
      #   conds = Hash[*parent_color.map { |b| [b, pp[:value].eq(b)] }.flatten]
      #   {
      #     name:   'Parent Color',
      #     scope:  :parent_color_any,
      #     conds:  conds,
      #     labels: (parent_color.sort).map { |k| [k, k] }
      #   }
      # end

      def ProductFilters.taxons_below(taxon)
        return Spree::Core::ProductFilters.all_taxons if taxon.nil?
        {
          name:   'Taxons under ' + taxon.name,
          scope:  :taxons_id_in_tree_any,
          labels: taxon.children.sort_by(&:position).map { |t| [t.name, t.id] },
          conds:  nil
        }
      end

      # Filtering by the list of all taxons
      #
      # Similar idea as above, but we don't want the descendants' products, hence
      # it uses one of the auto-generated scopes from Ransack.
      #
      # idea: expand the format to allow nesting of labels?
      def ProductFilters.all_taxons
        taxons = Spree::Taxonomy.all.map { |t| [t.root] + t.root.descendants }.flatten
        {
          name:   'All taxons',
          scope:  :taxons_id_equals_any,
          labels: taxons.sort_by(&:name).map { |t| [t.name, t.id] },
          conds:  nil 
        }
      end
    end
  end
end