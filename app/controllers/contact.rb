class Contact
	include ActiveModel::Model
	
	attr_accessor :first_name, :last_name, :contact_email, :zip_code, :location_id, :subject, :message

	def new_record?
		true
	end

	def initialize(attributes)
		@attributes = attributes
		@message = @attributes[:message]
		@subject = @attributes[:subject]
		@location_id = @attributes[:location_id]
		@zip_code = @attributes[:zip_code]
		@contact_email = @attributes[:contact_email]
		@last_name = @attributes[:last_name]
		@first_name = @attributes[:first_name]
	end

	validates_presence_of :message,
												:subject,
												:location_id,
												:zip_code,
												:contact_email,
												:last_name,
												:first_name

	def relevant_name
		case self.subject
		when 'marketing@alsformalwear.com'
		  relevant_name = 'Customer Service'
		when 'onlinesales@alsformalwear.com'
		  relevant_name = 'Individual Sales'
		when 'groupsales@alsformalwear.com'
		  relevant_name = 'Group / Org. Sales'
		when 'onlinesales@alsformalwear.com'
		  relevant_name = 'Online Store Question'
		when 'hr2@alsformalwear.com'
		  relevant_name = 'Human Resources'
		when 'marketing@alsformalwear.com'
		  relevant_name = 'Donation Requests'
		when 'webmaster@alsformalwear.com'
		  relevant_name = 'Website Question'
		else
		  relevant_name = 'Other'
		end
		return relevant_name
	end

end






