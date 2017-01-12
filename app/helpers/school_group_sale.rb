class SchoolGroupSale < ActiveRecord::Base

	validates_presence_of :number_uniforms,
												:group_type,
												:uniform_type,
												:teacher_name,
												:school_level,
												:school_type,
												:orgname,
												:school_district,
												:deadline,
												:budget,
												:contact_phone,
												:contact_email,
												:zip_code,
												:state,
												:city,
												:street_address,
												:last_name,
												:first_name


	validates_numericality_of :number_uniforms, :budget, :zip_code
  validate  :deadline_cannot_be_in_the_past
	# validates :deadline_string, format: { with: /(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.](19|20)\d\d/, message: "must be a valid date. (mm/dd/yyyy)" }
  validates_email_format_of :contact_email, message: "must be a valid email address.", if: :contact_email
  validates :contact_phone, format: { with: /\A([01][- .()])?(\(\d{3}\)|\d{3})[- .]*?\d{3}[- .]*\d{4}\Z/, message: "must be a valid 10-digit phone number." }

  def deadline_cannot_be_in_the_past
    errors.add(:deadline, "can't be in the past") if
    !deadline.blank? and deadline < Date.today
  end

  def self.human_attribute_name(attr, options = {})
    attr == :deadline_string ? 'Deadline' : super
  	attr == :orgname ? 'School Name' : super
  end

end








