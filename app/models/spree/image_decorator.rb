Spree::Image.class_eval do
  attachment_definitions[:attachment][:styles] = {
    :thumbnail => '30x44',
    :mini => '48x48>', 
    :small => '350x700>', 
    :medium => '1024x768>', 
    :large => '300x440#',
    :full => '800x1000>'
  }
end

