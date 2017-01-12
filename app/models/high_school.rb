class HighSchool < ActiveRecord::Base
	has_many :events

	def self.strip_names
		self.all.each do |hs|
			hs.update_attributes({
				name: hs.name.strip,
				name_first_half: hs.name_first_half.strip,
				name_second_half: hs.name_second_half.strip
			})
		end
	end

end