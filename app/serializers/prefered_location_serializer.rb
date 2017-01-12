require 'active_model_serializers'

class PreferedLocationSerializer < ActiveModel::Serializer
  attributes  :id,
              :formatted_for_select
  
  def id
    id = object.id
  end

  def formatted_for_select
    format_for_select = object.city
  end
end