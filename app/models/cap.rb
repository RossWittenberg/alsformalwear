class Cap
  include ActiveModel::Model
  attr_accessor :orgname, :street_address, :city, :state, :zip_code, :tax_id, :referral_name, :first_name, :last_name, :contact_title, :contact_phone, :location_id, :contact_email

  def new_record?
    true
  end

  def initialize(attributes)
    @attributes = attributes
    @orgname = @attributes[:orgname]
    @street_address = @attributes[:street_address]
    @city = @attributes[:city]
    @state = @attributes[:state]
    @zip_code = @attributes[:zip_code]
    @tax_id = @attributes[:tax_id]
    @referral_name = @attributes[:referral_name]
    @first_name = @attributes[:first_name]
    @last_name = @attributes[:last_name]
    @contact_title = @attributes[:contact_title]
    @contact_phone = @attributes[:contact_phone]
    @location_id = @attributes[:location_id]
    @contact_email = @attributes[:contact_email]
  end

  validates_presence_of :orgname, :street_address, :city, :state, :zip_code, :tax_id, :first_name, :last_name, :contact_phone, :location_id, :contact_email
  validates :contact_phone, format: { with: /\A([01][- .()])?(\(\d{3}\)|\d{3})[- .]*?\d{3}[- .]*\d{4}\Z/, message: "must be a valid 10-digit phone number." }

end