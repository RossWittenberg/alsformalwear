class OotMeasurement
  include ActiveModel::Model

  attr_accessor :bride_name, :groom_name, :group_number, :location_id, :contact_first, :contact_last, :date, :contact_email, :suit_size, :chest_overarm, :chest_underarm, :pants_waist, :pants_hip, :pants_outseam, :shirt_collar, :shirt_sleeve, :shoe_size, :height_feet, :height_inches, :weight, :fit_preference, :body_type, :id, :oot_date_string, :contact_phone

  validates_presence_of :bride_name, message: "Please enter the bride's name"
  validates_presence_of :groom_name, message: "Please enter the groom's name"
  validates_presence_of :location_id, message: "Please select a location"
  validates_presence_of :contact_email, message: "Email address can't be blank"
  validates_presence_of :contact_first, message: "Please enter your first name"
  validates_presence_of :contact_last, message: "Please enter your last name"
  validates_presence_of :contact_phone, message: "Please enter your phone number"
  validates :date, presence: { message: "Please select a date for your event" }
  validates_inclusion_of :suit_size, in: [nil,"Boys 2","Boys 3","Boys 4","Boys 6","Boys 8","Boys 10","Boys 12","Boys 14","Boys 16","Boys 18","34S","35S","36S","37S","38S","39S","40S","41S","42S","43S","44S","46S","48S","50S","52S","54S","56S","58S","60S","34R","35R","36R","37R","38R","39R","40R","41R","42R","43R","44R","46R","48R","50R","52R","54R","56R","58R","60R","62R","64R","66R","68R","70R","36L","37L","38L","39L","40L","41L","42L","43L","44L","46L","48L","50L","52L","54L","56L","58L","60L","62L","64L","66L","68L","70L","38XL","39XL","40XL","41XL","42XL","43XL","44XL","46XL","48XL","50XL","52XL","54XL","56XL","58XL"], message: "Please select a valid suit size"
  validates_inclusion_of :chest_overarm, in: (25..75).to_a << nil, message: 'Chest overarm should be between 25-75"', if: :chest_overarm?
  validates_inclusion_of :chest_underarm, in: (25..75).to_a << nil, message: 'Chest underarm should be between 25-75"', if: :chest_underarm?
  validates_inclusion_of :pants_waist, in: (17..60).to_a << nil, message: 'Waist should be between 17-60"' , if: :pants_waist?
  validates_inclusion_of :pants_hip, in: (20..80).to_a << nil, message: 'Hips should be between 20-80"', if: :pants_hip?
  validates_inclusion_of :pants_outseam, in: (22..54).step(0.5).to_a << nil, message: 'Outseam should be between 22-54"', if: :pants_outseam? 
  validates_inclusion_of :fit_preference, in: ["Classic", "Modern", "Slim", nil], message: 'Please select a fit'
  validates_inclusion_of :body_type, in: ["Muscular", "Hefty", "Slender", "Normal", nil], message: 'Please select a body type'
  validate :event_date_cannot_be_in_the_past
  validates_email_format_of :contact_email, if: :contact_email?
  validates :oot_date_string, format: { with: /(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.](19|20)\d\d/, message: "Please enter a valid date. (mm/dd/yyyy)" }, unless: :date
  validates :contact_phone, format: { with: /\A([01][- .()])?(\(\d{3}\)|\d{3})[- .]*?\d{3}[- .]*\d{4}\Z/, message: "Phone must be a valid 10-digit phone number." }

  def new_record?
    true
  end

  def initialize(attributes)
    @attributes = attributes
    @bride_name = @attributes[:bride_name]
    @groom_name = @attributes[:groom_name]
    @group_number = @attributes[:group_number]
    @location_id = @attributes[:location_id]
    @contact_first = @attributes[:contact_first]
    @contact_last = @attributes[:contact_last]
    @date = @attributes[:date]
    @contact_email = @attributes[:contact_email]
    @contact_phone = @attributes[:contact_phone]
    @suit_size = @attributes[:suit_size]
    @chest_overarm = @attributes[:chest_overarm]
    @chest_underarm = @attributes[:chest_underarm]
    @pants_waist = @attributes[:pants_waist]
    @pants_hip = @attributes[:pants_hip]
    @pants_outseam = @attributes[:pants_outseam]
    @shirt_collar = @attributes[:shirt_collar]
    @shirt_sleeve = @attributes[:shirt_sleeve]
    @shoe_size = @attributes[:shoe_size]
    @height_feet = @attributes[:height_feet]
    @height_inches = @attributes[:height_inches]
    @weight = @attributes[:weight]
    @fit_preference = @attributes[:fit_preference]
    @body_type = @attributes[:body_type]
    @id = @attributes[:id]
    @oot_date_string = @attributes[:oot_date_string]
  end

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

  def contact_email?
    !self.contact_email.blank?
  end

  def chest_overarm?
    !self.chest_overarm.blank?
  end

  def chest_underarm?
    !self.chest_underarm.blank?
  end

  def pants_waist?
    !self.pants_waist.blank?
  end

  def pants_hip?
    !self.pants_hip.blank?
  end

  def pants_outseam?
    !self.pants_outseam.blank?
  end




  def event_date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
    !date.blank? and date < Date.today
  end
end