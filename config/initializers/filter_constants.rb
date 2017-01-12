OPTION_FILTERS = [ "parent-color", "child-color" ]
PROPERTY_FILTERS = Spree::Property.all.map(&:name).map { |p| p.gsub("_", "-")}
COLORS = COLOR_PAIRS.keys + COLOR_PAIRS.values.flatten
VARIANT_COUNT = Spree::Variant.all.count