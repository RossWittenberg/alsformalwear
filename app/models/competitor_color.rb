class CompetitorColor < ActiveRecord::Base
	belongs_to :parent_color

	validates_presence_of :name, :hex
	
end