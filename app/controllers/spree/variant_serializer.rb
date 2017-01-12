require 'active_model_serializers'

module Spree
  class VariantSerializer < ActiveModel::Serializer
    attributes :designer, 
               :product_name,
               :image_url_thumbnail,
               :image_url_mini,
               :image_url_small, 
               :image_url_medium,
               :image_url_large,
               :image_url_full,
               :image_url_byt,
               :image_url_secondary_byt,
               :parent_color,
               :child_color,
               :product_id,
               :variant_id,
               :featured,
               :description,
               :style_number,
               :slug,
               :id,
               :product_category, 
               :product_path,
               :product_category_for_print

    def product_path
      path = object.path
    end

    def style_number
      style_number = object.sku
    end 

    def slug
      slug = object.product.slug
    end

    def designer
      designer = object.product.designer
    end

    def product_name
      name = object.product.name
    end

    def image_url_thumbnail
      image_url_thumbnail = object.display_image.attachment(:thumbnail)
    end

    def image_url_mini
      object.display_image.attachment(:mini)
    end

    def image_url_small
      object.display_image.attachment(:small)
    end

    def image_url_medium
      object.display_image.attachment(:medium)
    end

    def image_url_large
      object.display_image.attachment(:large)
    end

    def image_url_full
      object.display_image.attachment(:full)
    end   

    def image_url_byt
      object.byt_image.url
    end  

    def image_url_secondary_byt
      object.secondary_byt_image.url
    end     

    def parent_color
      object.option_values.each do |ov|
        if ov.option_type.name == "parent_color"
          parent_color = ov.presentation
          return parent_color
        end
      end
    end

    def child_color
      object.option_values.each do |ov|
        if ov.option_type.name == "child_color"
          child_color = ov.presentation
          return child_color
        end
      end   
    end

    def taxon_ids
      taxon_ids = object.product.taxons.uniq.map(&:id)
    end

    def product_id
      object.product_id
    end

    def variant_id
      object.id
    end

    def featured
      featured = object.product.featured
    end

    def product_category
      object.category_slug
    end

    def product_category_for_print
      object.category_value
    end

  end
end