class Measurement < ActiveRecord::Base

	belongs_to :user

  validates_inclusion_of :suit_size, in: [nil,"Boys 2","Boys 3","Boys 4","Boys 6","Boys 8","Boys 10","Boys 12","Boys 14","Boys 16","Boys 18","34S","35S","36S","37S","38S","39S","40S","41S","42S","43S","44S","46S","48S","50S","52S","54S","56S","58S","60S","34R","35R","36R","37R","38R","39R","40R","41R","42R","43R","44R","46R","48R","50R","52R","54R","56R","58R","60R","62R","64R","66R","68R","70R","36L","37L","38L","39L","40L","41L","42L","43L","44L","46L","48L","50L","52L","54L","56L","58L","60L","62L","64L","66L","68L","70L","38XL","39XL","40XL","41XL","42XL","43XL","44XL","46XL","48XL","50XL","52XL","54XL","56XL","58XL"], message: "Please Select a Valid Suit Size"
  validates_inclusion_of :chest_overarm, in: (25..75).to_a << nil, message: 'Chest overarm should be between 25-75"' 
  validates_inclusion_of :chest_underarm, in: (25..75).to_a << nil, message: 'Chest underarm should be between 25-75"' 
  validates_inclusion_of :pants_waist, in: (17..60).to_a << nil, message: 'Waist should be between 17-60"' 
  validates_inclusion_of :pants_hip, in: (20..80).to_a << nil, message: 'Hips should be between 20-80"' 
  validates_inclusion_of :pants_outseam, in: (22..54).step(0.5).to_a << nil, message: 'Outseam should be between 22-54"' 
  
  validates_inclusion_of :fit_preference, in: ["Classic", "Modern", "Slim", nil]


	def self.shirt_collar
		i = 13.5
		shirt_collar = []
		while i < 24
			shirt_collar << i
			i += 0.5
		end
		return shirt_collar
	end 

	def self.shirt_sleeve
		i = 31
		shirt_sleeve = []
		while i < 41
			shirt_sleeve << "#{i}"
			i += 1
		end
		return shirt_sleeve
	end 

	def self.shoe_size
		i = 6.5
		shoe_size = []
		while i < 20.5
			shoe_size << "Mens #{i} M"
      shoe_size << "Mens #{i} W"
			i += 0.5
		end
		return shoe_size
	end 
	
end
