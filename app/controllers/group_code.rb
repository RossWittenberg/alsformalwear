class GroupCode < ActiveRecord::Base
	belongs_to :location
	belongs_to :event

	validates_uniqueness_of :number

	def self.newGroupCodesFromAdmin(startNum, endNum, location)
		total_codes = endNum.to_i - startNum.to_i
		gc_array = []
		i = 0
		while i <= total_codes
			gc = GroupCode.new({ number: startNum.to_i + i, location_id: location.id })
			i += 1
			if gc.save
				gc_array << gc
			else
				@errors = gc.errors
				return @errors
			end
		end
		return gc_array
	end

	def self.validateStartAndEndNum(startNum, endNum)
		errors = []
		# check numericality
		errors.push("Start Number must be a number") unless startNum !~ /\D/
		errors.push("End Number must be a number") unless endNum !~ /\D/
		return false if errors.count > 0
		# check that start and end are positive
		errors.push("Start and End Number must both be positive integers") unless (endNum.to_i > 0) && (startNum.to_i > 0)
		return false if errors.count > 0
		# check End is larger than Start
		errors.push("End Number must be larger than Start Number") unless endNum.to_i > startNum.to_i
		return false if errors.count > 0
		# check that codes have greater than 3 digits
		errors.push("Start and End Number must contain at least 3 digits each") unless (endNum.length > 2) && (startNum.length > 2)
		if errors.count > 0
			return false
		else 
			return true
		end
	end
end