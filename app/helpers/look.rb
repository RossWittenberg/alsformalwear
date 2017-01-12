class Look < ActiveRecord::Base
	belongs_to :user
	belongs_to :event
	
	def has_event?
		self.event_id.present?
	end

	def coatandpants
		coatandpants = Spree::Variant.find self.products["coatandpants"]
		coatandpants = coatandpants.product
	end

	def vestandcummerbund
		vestandcummerbund = Spree::Variant.find self.products["vestandcummerbund"]
		vestandcummerbund = vestandcummerbund.product
	end

	def shirt
		shirt = Spree::Variant.find self.products["shirt"]
		shirt = shirt.product
	end

	def tie
		tie = Spree::Variant.find self.products["tie"]
		tie = tie.product
	end

	def shoe
		shoe = Spree::Variant.find self.products["shoes"]
		shoe = shoe.product
	end

	def accessories
		accessories = Spree::Variant.find self.products["accessories"]
		accessories = accessories.product
	end

end	