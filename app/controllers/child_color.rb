class ChildColor < ActiveRecord::Base
	belongs_to :parent_color

	validates_presence_of :name, :hex

	def self.unused?
		self.all.map { |cc| Spree::Variant.check_if_child_color_exists(cc.name) }
	end

end
	