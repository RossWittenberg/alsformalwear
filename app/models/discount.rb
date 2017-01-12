class Discount < ActiveRecord::Base

	belongs_to :location

	validates_presence_of :date,
												:contact_email,
                        :location_id

	validates_presence_of :custom_discount, :contact_name, :contact_phone, if: :is_wedding?
	validates_presence_of :first_name, :last_name, :contact_phone, :zip_code, :event_type,  unless: :is_wedding?
	validates :wedding_date_string, format: { with: /(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.](19|20)\d\d/, message: "Please enter a valid date. (mm/dd/yyyy)" }, unless: :date
	validates_email_format_of :contact_email, if: :contact_email?
	validate  :event_date_cannot_be_in_the_past


	def is_wedding?
		self.wedding
	end

	def contact_email?
		!self.contact_email.blank?
	end

	def event_date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
    !date.blank? and date < Date.today
  end

  def combined_name
  	if self.first_name.present? && self.last_name.present?
  		return "#{self.first_name} #{self.last_name}" 
  	elsif self.contact_name.present?
  		return self.contact_name
  	else
  		return "Not Provided"
  	end
  end

  def modified_event_type
  	if self.wedding == true
  		return "Wedding"
  	elsif self.event_type
  		return self.event_type.humanize.capitalize
  	else
  		return "Not Provided"
  	end
  end

  def self.to_general_csv
    attributes = %w{name  contact_email  contact_phone  zip_code  event_type  date  location  created_at}
    CSV.generate( { headers: true } ) do |csv|
      csv << attributes
      self.order(created_at: :desc).each do |discount|
        location = Location.find discount.location_id if discount.location_id.present?
        location.present? ? location_name = discount.location.store_name : location_name = "not specified"
        csv << [ discount.combined_name,
                 discount.contact_email,
                 discount.contact_phone,
                 discount.zip_code,
                 discount.modified_event_type,
                 (discount.date && (discount.date.in_time_zone("Central Time (US & Canada)")).strftime("%m/%d/%Y") || "not specified"),
                 location_name,
                 (discount.created_at.in_time_zone("Central Time (US & Canada)")).strftime("%m/%d/%Y")]
      end 
    end
  end

  def self.to_wedding_csv
    attributes = %w{name  contact_email  contact_phone  zip_code  event_type  date  location custom_discount best_man groomsmen fot_bride fot_groom ringbearer ushers attendants created_at }
    CSV.generate( { headers: true } ) do |csv|
      csv << attributes
      self.order(created_at: :desc).each do |discount|
        location = Location.find discount.location_id if discount.location_id.present?
        location.present? ? location_name = discount.location.store_name : location_name = "not specified"
        csv << [ discount.combined_name,
                 discount.contact_email,
                 discount.contact_phone,
                 discount.zip_code,
                 discount.modified_event_type,
                 (discount.date && (discount.date.in_time_zone("Central Time (US & Canada)")).strftime("%m/%d/%Y") || "not specified"),
                 location_name,
                 "$#{discount.custom_discount}" || "Not Provided",
                 discount.best_man.to_s,
                 discount.groomsmen || "Not Provided",
                 discount.fot_bride.to_s,
                 discount.fot_groom.to_s,
                 discount.ringbearer.to_s,
                 discount.ushers || "Not Provided",
                 discount.attendants || "Not Provided",
                 (discount.created_at.in_time_zone("Central Time (US & Canada)")).strftime("%m/%d/%Y")]
      end 
    end
  end

end



 


  



