class Event < ActiveRecord::Base
	belongs_to :user
	belongs_to :location
	belongs_to :high_school
	has_one :look
	has_one :group_code

	validates :school_zip_code, presence: { message: "Please enter your school's zip code" }, if: :prom_rep?
	validates :school_state, presence: { message: "Please select your school's state" }, if: :prom_rep?
	validates :school_city, presence: { message: "Please enter your school's city" }, if: :prom_rep?
	validates :contact_phone, presence: { message: "Please enter your phone number" }, if: :prom_rep?, :on => :create

	validates :orgname, presence: { message: "Please enter your school name" }, if: :school_event?, :on => :create
	validates :orgname, presence: { message: "Please enter your organization name" }, if: :social_event?, :on => :create
  validates_email_format_of :groom_email, message: "Please enter a valid email for the groom", if: :has_groom_email?
  validates_email_format_of :bride_email, message: "Please enter a valid email for the bride", if: :has_bride_email?
	validates :groom_email, presence: { message: "Please enter the groom's email address" }, if: :is_bridal_group?
	validates :bride_email, presence: { message: "Please enter the bride's email address" }, if: :is_bridal_group?
	validates :groom_last_name, presence: { message: "Please enter the groom's last name" }, if: :is_bridal_group?
	validates :bride_last_name, presence: { message: "Please enter the bride's last name" }, if: :is_bridal_group?
	validates :groom_first_name, presence: { message: "Please enter the groom's first name" }, if: :is_bridal_group?
	validates :bride_first_name, presence: { message: "Please enter the bride's first name" }, if: :is_bridal_group?
	validates :other_explain, presence: { message: "Please tell us about your event" }, if: :is_other?
	validates :event_type, presence: { message: "Please select a type for your event" }
	validates :location_id, presence: { message: "Please select a preferred Al's location" }, if: :is_group?
	validates :contact_phone, presence: { message: "Please enter your phone number" }, if: :requires_phone?, :on => :create
  validates :contact_phone, format: { with: /\A([01][- .()])?(\(\d{3}\)|\d{3})[- .]*?\d{3}[- .]*\d{4}\Z/, message: "Please enter a valid 10-digit phone number." }, if: :requires_phone?
	validates :role, presence: { message: "Please select a valid role" }, if: :is_bridal_group?, on: :create
	validates :last_name, presence: { message: "Please enter your last name" }, if: :is_group?, on: :create
	validates :first_name, presence: { message: "Please enter your first name" }, if: :is_group?, on: :create
	validates :date, presence: { message: "Please select a date for your event" }
	validates_inclusion_of :black_tie, in: [ true, false ], message: "Please indicate whether the event is a black tie", if: :school_fundraiser?
	validates_inclusion_of :juniors, in: [ true, false ], message: "Please indicate whether juniors will be attending", if: :school_fundraiser?
	validates :event_name, presence: { message: "Please enter a name for your event" }, if: :requires_event_name?
	validates_inclusion_of :school_year, in: ['Freshman','Sophomore','Junior','Senior'],  message: "Please select your school year", if: :prom_rep?
	validates :zip_code, presence: { message: "Please enter your zip code" }, if: :is_group?
	validates :state, presence: { message: "Please select your state" }, if: :is_group?
	validates :city, presence: { message: "Please enter your city" }, if: :is_group?
	validates :street_address, presence: { message: "Please enter your mailing address" }, if: :is_group?


  validate  :event_date_cannot_be_in_the_past, :on => :create

	validates :event_date_string, format: { with: /(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.](19|20)\d\d/, message: "Please enter a valid date. (mm/dd/yyyy)" }, on: :create, unless: :date?

	def self.mark_events_with_group_codes_as_exported
		yet_to_be_sent_group_events = Event.select { |event| (event.created_at >= Time.zone.now.beginning_of_day && event.is_group == true) || (event.updated_at >= Time.zone.now.beginning_of_day && event.is_group == true && event.exported == false ) }
		
		past_group_events = Event.select { |event| (event.created_at <= Time.zone.now.beginning_of_day && event.is_group == true) || (event.updated_at <= Time.zone.now.beginning_of_day && event.is_group == true && event.exported == false ) }
		
		past_group_events_not_marked_as_false = past_group_events.select{ |event| event.exported == false  }
		
		past_group_events_marked_as_false = past_group_events_not_marked_as_false.compact.flatten.map do |event|
			event.exported = true
			if event.save
				puts "saved!"
			else
				puts event.errors.full_messages
			end
		end

		events_yet_to_be_exported = yet_to_be_sent_group_events.compact.flatten.map do |event|
			event.exported = false
			if event.save
				puts "saved!"
			else
				puts event.errors.full_messages
			end
		end

		past_group_events_not_marked_as_false.each do |event|
			puts "Past Events: Group Code = #{event.group_code.number} -- Marked as Exported?  #{event.exported}"
		end

		yet_to_be_sent_group_events.each do |event|
			puts "Events added Today: Group Code = #{event.group_code.number} -- Marked as Exported?  #{event.exported}"
		end

	end

	def self.update_social_event_fundraiser_value
		self.all.each do |event|
			if event.is_group && ( event.event_type == "social_event" || event.event_type == "socia event" )
				event.update_attributes({social_event_fundraiser: true})
			else
				event.update_attributes({social_event_fundraiser: false})
			end
		end
	end

  def event_date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
    !date.blank? and date < Date.today
  end


	def add_group_code
		if self.location.present?
			self.group_code = GroupCode.where(location_id: self.location.id).select { |gc| gc.event_id == nil }.first
		else
			self.group_code = nil
		end
	end

	def has_look?
		self.look.present?
	end

	def is_other?
		self.event_type == "other"
	end

	def is_bridal_group?
		self.is_group && (self.event_type == "wedding")
	end

	def has_bride_email?
		self.is_bridal_group? && self.bride_email.present?
	end

	def has_groom_email?
		self.is_bridal_group? && self.groom_email.present?
	end

	def school_event?
		self.school_fundraiser? || self.prom_rep
	end

	def social_event?
		(self.event_type == "social event")
	end

	def requires_phone?
		self.school_fundraiser? || (self.event_type == "wedding" && self.is_group? ) || (self.event_type == "social event" && self.is_group?)
	end

	def requires_event_name?
		self.is_bridal_group? || self.event_type == "social event" || self.school_fundraiser?
	end

	def type_to_number
		case self.event_type
		when "wedding"
			return 1
		when "quinceanera"
			return 2
		when "prom"
			return 3
		when "social event" || "social_event"
			return 5
		else
			return 9
		end
	end

	def convert_to_string_for_export
		if self.group_code.present?
			self.update_attributes ({exported: true})

			affair_date = self.date

			string_for_export_array = []
			empty_quotes = ""
			space_in_quotes = " "

			grphdr_affair_nbr = self.group_code.number.to_s
			grphdr_reg_dt = "today"
			grphdr_reg_tm = "050000"
			grphdr_reg_store = ( self.location && self.location.store_num ) || "NULL"
			grphdr_reg_salrep = ( self.location && self.location.store_num ) || "NULL"
			grphdr_sch_pkup_st = ( self.location && self.location.store_num ) || "NULL"
			if self.event_type == "wedding" || self.event_type == "quinceanera"
				grphdr_sch_pkup_dt = (affair_date - 2.days).strftime("%m/%d/%Y")
			else 
				grphdr_sch_pkup_dt = (affair_date - 1.days).strftime("%m/%d/%Y")
			end	
			grphdr_sch_retn_dt = (affair_date + 1.days).strftime("%m/%d/%Y")
			grphdr_affair_dt = self.date.strftime("%m/%d/%Y") || "NULL"
			grphdr_affair_type = self.type_to_number.to_s
			# bride
			self.type_to_number == 1 ?  grphdr_br_lname = self.bride_last_name : grphdr_br_lname = self.orgname[0..15]
			self.type_to_number == 1 ?  grphdr_br_fname = self.bride_first_name : grphdr_br_fname = self.orgname[16..(self.orgname.length)-1]
			self.type_to_number == 3 ?  grphdr_br_addr1 = self.high_school.number rescue nil : ( (self.role == "bride" || self.role == "Bride") ? grphdr_br_addr1 = self.street_address : grphdr_br_addr1 = "NULL")
			self.type_to_number == 3 ?  grphdr_br_city = "" : ( (self.role == "bride" || self.role == "Bride") ? grphdr_br_city = self.city : grphdr_br_city = "")
			self.type_to_number == 3 ?  grphdr_br_state = " " : ( (self.role == "bride" || self.role == "Bride") ?  grphdr_br_state = self.state : grphdr_br_state = " ")
			self.type_to_number == 3 ?  grphdr_br_zip = "NULL" : ( (self.role == "bride" || self.role == "Bride") ?  grphdr_br_zip = self.zip_code : grphdr_br_zip = "NULL")
			self.type_to_number == 3 ?  grphdr_br_harea = "NULL" : ( (self.role == "bride" || self.role == "Bride") ?  grphdr_br_harea = self.contact_phone.gsub("-","")[0..2] : grphdr_br_harea = "NULL")
			self.type_to_number == 3 ?  grphdr_br_hphone = "NULL" : ( (self.role == "bride" || self.role == "Bride") ?  grphdr_br_hphone = self.contact_phone.gsub("-","")[3..9] : grphdr_br_hphone = "NULL")
			grphdr_br_warea = "NULL"
			grphdr_br_wphone = "NULL"
			self.type_to_number == 3 ?  grphdr_br_email = "" : ( (self.role == "bride" || self.role == "Bride") ?  grphdr_br_email = self.bride_email : grphdr_br_email = "")
	    # groom
	    self.type_to_number == 1 ?  grphdr_gr_lname = self.bride_last_name : grphdr_gr_lname = self.orgname[0..15]
			self.type_to_number == 1 ?  grphdr_gr_fname = self.bride_first_name : grphdr_gr_fname = self.orgname[16..(self.orgname.length)-1]
			self.type_to_number == 3 ?  grphdr_gr_addr1 = self.tax_id.gsub("-", "") rescue nil : ( (self.role == "groom" || self.role == "Groom") ? grphdr_gr_addr1 = self.street_address : grphdr_gr_addr1 = "NULL")
			self.type_to_number == 3 ?  grphdr_gr_city = "" : ( (self.role == "groom" || self.role == "Groom") ? grphdr_gr_city = self.city : grphdr_gr_city = "")
			self.type_to_number == 3 ?  grphdr_gr_state = " " : ( (self.role == "groom" || self.role == "Groom") ?  grphdr_gr_state = self.state : grphdr_gr_state = " ")
			self.type_to_number == 3 ?  grphdr_gr_zip = "NULL" : ( (self.role == "groom" || self.role == "Groom") ?  grphdr_gr_zip = self.zip_code : grphdr_gr_zip = "NULL")
			self.type_to_number == 3 ?  grphdr_gr_harea = "NULL" : ( (self.role == "groom" || self.role == "Groom") ?  grphdr_gr_harea = self.contact_phone.gsub("-","")[0..2] : grphdr_gr_harea = "NULL")
			self.type_to_number == 3 ?  grphdr_gr_hphone = "NULL" : ( (self.role == "groom" || self.role == "Groom") ?  grphdr_gr_hphone = self.contact_phone.gsub("-","")[3..9] : grphdr_gr_hphone = "NULL")
			grphdr_gr_warea = "NULL"
			grphdr_gr_wphone = "NULL"
			self.type_to_number == 3 ?  grphdr_gr_email = "" : ( (self.role == "groom" || self.role == "Groom") ?  grphdr_gr_email = self.bride_email : grphdr_gr_email = "")
			grphdr_tax_flag = "1"
			grphdr_status = "0"
			grphdr_update_dt = "today"
			grphdr_update_tm = "050000"

			header_string = "insert into grphdr ( grphdr_affair_nbr, grphdr_reg_dt, grphdr_reg_tm, grphdr_reg_store, grphdr_reg_salrep, grphdr_sch_pkup_st, grphdr_sch_pkup_dt, grphdr_sch_retn_dt, grphdr_affair_dt, grphdr_affair_type, grphdr_br_lname, grphdr_br_fname, grphdr_br_addr1, grphdr_br_city, grphdr_br_state, grphdr_br_zip, grphdr_br_harea, grphdr_br_hphone, grphdr_br_warea, grphdr_br_wphone, grphdr_br_email, grphdr_gr_lname, grphdr_gr_fname, grphdr_gr_addr1, grphdr_gr_city, grphdr_gr_state, grphdr_gr_zip, grphdr_gr_harea, grphdr_gr_hphone, grphdr_gr_warea, grphdr_gr_wphone, grphdr_gr_email, grphdr_tax_flag, grphdr_status, grphdr_update_dt, grphdr_update_tm ) values ("

			# date
			grphdr_affair_dt   = grphdr_affair_dt   == "NULL" ? grphdr_affair_dt : "\"#{grphdr_affair_dt}\""

			grphdr_sch_pkup_dt = grphdr_sch_pkup_dt == "NULL" ? grphdr_sch_pkup_dt : "\"#{grphdr_sch_pkup_dt}\""
			grphdr_sch_retn_dt = grphdr_sch_retn_dt == "NULL" ? grphdr_sch_retn_dt : "\"#{grphdr_sch_retn_dt}\""
			# bride
			grphdr_br_lname    = grphdr_br_lname    == "NULL" ? "NULL" : "\"#{grphdr_br_lname}\""
			grphdr_br_fname    = grphdr_br_fname    == "NULL" ? "NULL" : "\"#{grphdr_br_fname}\""
			grphdr_br_addr1    = grphdr_br_addr1    == "NULL" ? "NULL" : ( grphdr_br_addr1.class == Fixnum ? grphdr_br_addr1 : "\"#{grphdr_br_addr1}\"")
			grphdr_br_city     = grphdr_br_city     == "" ? "\"#{empty_quotes}\"" : "\"#{grphdr_br_city}\""
			grphdr_br_state    = grphdr_br_state    == " " ? "\"#{space_in_quotes}\"" : "\"#{grphdr_br_state}\""
			grphdr_br_email    = grphdr_br_email    == "" ? "\"#{empty_quotes}\"" : "\"#{grphdr_br_email}\""
			# groom      
			grphdr_gr_lname    = grphdr_gr_lname    == "NULL" ? "NULL" : "\"#{grphdr_gr_lname}\""
			grphdr_gr_fname    = grphdr_gr_fname    == "NULL" ? "NULL" : "\"#{grphdr_gr_fname}\""
			grphdr_gr_addr1    = grphdr_gr_addr1    == "NULL" ? "NULL" : "\"#{grphdr_gr_addr1}\""
			grphdr_gr_city     = grphdr_gr_city     == "" ? "\"#{empty_quotes}\"" : "\"#{grphdr_gr_city}\""
			grphdr_gr_state    = grphdr_gr_state    == " " ? "\"#{space_in_quotes}\"" : "\"#{grphdr_gr_state}\""
			grphdr_gr_email    = grphdr_gr_email    == "" ? "\"#{empty_quotes}\"" : "\"#{grphdr_gr_email}\""
   
			string_for_export_array << grphdr_affair_nbr << grphdr_reg_dt << grphdr_reg_tm << grphdr_reg_store << grphdr_reg_salrep << grphdr_sch_pkup_st << grphdr_sch_pkup_dt << grphdr_sch_retn_dt << grphdr_affair_dt << grphdr_affair_type << grphdr_br_lname << grphdr_br_fname << grphdr_br_addr1 << grphdr_br_city << grphdr_br_state << grphdr_br_zip << grphdr_br_harea << grphdr_br_hphone << grphdr_br_warea << grphdr_br_wphone << grphdr_br_email << grphdr_gr_lname << grphdr_gr_fname << grphdr_gr_addr1 << grphdr_gr_city << grphdr_gr_state << grphdr_gr_zip << grphdr_gr_harea << grphdr_gr_hphone << grphdr_gr_warea << grphdr_gr_wphone << grphdr_gr_email << grphdr_tax_flag << grphdr_status << grphdr_update_dt << grphdr_update_tm

			string_for_export  = header_string << string_for_export_array.join(", ") << ");\n"
			string_for_export
		end	
	end

	def self.convert_to_pos_main_string_for_export
		events_to_be_exported = []
		events_to_be_exported << self.where("created_at >= ? AND is_group = ?", Time.zone.now.beginning_of_day - 1.days + 10.hours, true)
		events_to_be_exported << self.where("updated_at >= ? AND is_group = ? AND exported = ?", Time.zone.now.beginning_of_day - 1.days + 10.hours, true, false)
		events_to_be_exported.flatten!
		events_to_be_exported.compact!
		group_codes = events_to_be_exported.map(&:group_code).compact.uniq
		sql = group_codes.map {|gc| gc.number.to_s}.join(",\n")
		header_string = "select count(*) as counted," + "\"#{group_codes.count}.0 as shouldbe\"" + " from grphdr where grphdr_affair_nbr in (\n"
		string_for_export = header_string << sql << ",\n0);"
		string_for_export
	end

	def modified_event_type
		case self.event_type
		when "social_event"
			return "social event"
		when "prom_formal"
			return "prom"
		else
			return self.event_type
		end
	end

  def self.to_csv
		attributes = %w{user_email user_first_name user_last_name event_name date event_type role groom_first_name groom_last_name created_at updated_at bride_first_name bride_last_name look_id first_name last_name location_store_name orgname street_address city state zip_code tax_id referral_name contact_title contact_phone school_year bride_email groom_email is_group juniors black_tie prom_rep school_fundraiser school_city school_state school_zip_code school_street_address other_explain number_juniors number_seniors social_event_fundraiser group_code }
		CSV.generate( { headers: true } ) do |csv|
			csv << attributes
		  self.order(created_at: :desc).each do |event|
				user = Spree::User.find event.user_id
		    csv << [ ( user.present? ? user.email : ""), ( user.present? ? user.first_name : ""), ( user.present? ? user.last_name : ""), event.event_name, event.date.strftime("%m/%d/%Y"), event.modified_event_type, event.role, event.groom_first_name, event.groom_last_name, (event.created_at.in_time_zone("Central Time (US & Canada)")).strftime("%m/%d/%Y"), (event.updated_at.in_time_zone("Central Time (US & Canada)")).strftime("%m/%d/%Y"), event.bride_first_name, event.bride_last_name, event.look_id, event.first_name, event.last_name, ( ( (Location.find event.location_id).store_num if event.location_id) || "No Location Selected" ), event.orgname, event.street_address, event.city, event.state, event.zip_code, event.tax_id, event.referral_name, event.contact_title, event.contact_phone, event.school_year, event.bride_email, event.groom_email, event.is_group, event.juniors, event.black_tie, (event.prom_rep || 'false'), event.school_fundraiser, event.school_city, event.school_state, event.school_zip_code, event.school_street_address, event.other_explain, event.number_juniors, event.number_seniors, event.social_event_fundraiser, ( event.group_code ? event.group_code.number : "No group code" )]
		  end 
		end
  end

	def self.updated_exported
		self.all.map do |e| 
			if (e.is_group?) && (e.created_at < Time.zone.now.beginning_of_day - 2.days)
				e.update_attributes({exported: true})
			end
		end
	end

end
