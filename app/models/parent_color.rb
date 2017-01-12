class ParentColor < ActiveRecord::Base
	has_many :child_colors
	has_many :competitor_colors

end
