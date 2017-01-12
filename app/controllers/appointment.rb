class Appointment < ActiveRecord::Base
	belongs_to :location
												
  validates_presence_of :appointment_reason,
                      :contact_time,
                      :appointment_date,
                      :approximate_event_date,
                      :contact_method,
                      :location_id,
                      :zip_code,
                      :contact_phone,
                      :contact_email,
                      :last_name,
                      :first_name

  validates :apt_time, presence: { message: "must include both hours and minutes" }
  validate  :appointment_date_cannot_be_in_the_past
  validates_email_format_of :contact_email, message: "must be a valid email address.", if: :contact_email
  validates :contact_phone, format: { with: /\A([01][- .()])?(\(\d{3}\)|\d{3})[- .]*?\d{3}[- .]*\d{4}\Z/, message: "must be a valid 10-digit phone number." }

  def appointment_date_cannot_be_in_the_past
    errors.add(:appointment_date, "can't be in the past") if !appointment_date.blank? && appointment_date.past?
    errors.add(:approximate_event_date, "can't be in the past") if !approximate_event_date.blank? && approximate_event_date.past?
  end

  def self.human_attribute_name(attr, options = {})
    attr == :apt_time ? 'Appointment Time' : ( attr == :appointment_date_string ? 'Appointment date' : super )
  end

  def demilitarize_time
  	self.apt_time.to_time.strftime("%I:%M %p") 
  end

  def has_appointment_date?
  	self.appointment_date.present?
  end

  def self.add_exisiting_appointments
  	csv_file_path = 'db/seeds/old_appointments.csv'
		CSV.foreach(csv_file_path, :headers => true ) do |row|
			row["appointment_date"] = DateTime.strptime(row["appointment_date"], '%m/%d/%Y').to_time
			location_name = row["location_name"]
			created_at = DateTime.strptime(row["created_at"], '%m/%d/%Y').to_t
			row.delete "location_name"
			row.delete "created_at"
		  a = Appointment.create!(row.to_hash)
			a.update_attributes({created_at: created_at})
			location = Location.find_by_store_name location_name
			a.location = location
			a.save
		end
  end

  def adjust_year
    if self.created_at.year == 16
      self.update_attributes({created_at: (self.created_at + 2000.year) })
    end
  end

  def self.to_csv
    attributes = %w{first_name last_name contact_email contact_phone zip_code location group_code contact_time contact_method appointment_date approximate_event_date apt_time appointment_reason other_explain wedding_apt_details message created_at}
    CSV.generate( { headers: true } ) do |csv|
      csv << attributes
      self.order(created_at: :desc).each do |appointment|
        location = Location.find appointment.location_id if appointment.location_id.present?
        location.present? ? location_name = appointment.location.store_name : location_name = "not specified"
        csv << [ appointment.first_name,
                 appointment.last_name,
                 appointment.contact_email,
                 appointment.contact_phone,
                 appointment.zip_code,
                 location_name,
                 appointment.group_code,
                 appointment.contact_time,
                 appointment.contact_method,
                 (appointment.appointment_date && (appointment.appointment_date.in_time_zone("Central Time (US & Canada)")).strftime("%m/%d/%Y") || "not specified"),
                 (appointment.approximate_event_date && appointment.approximate_event_date.strftime("%m/%d/%Y") || "not specified" ),
                 appointment.demilitarize_time,
                 appointment.appointment_reason,
                 appointment.other_explain,
                 appointment.wedding_apt_details,
                 appointment.message,
                 (appointment.created_at.in_time_zone("Central Time (US & Canada)")).strftime("%m/%d/%Y")]
      end 
    end
  end

end




