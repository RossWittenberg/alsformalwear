class Location < ActiveRecord::Base

	require 'csv'

	def to_param
		"#{store_num}".parameterize
	end
	
  has_attached_file :store_image, 
	styles: { 
		thumbnail: '100x186',
		mobile:  '280x466',
		desktop: '400x666',
    product: '600x1000>'},
  default_url: "https://s3.amazonaws.com/alsformalwear-assets/images/store-default.png"

  validates_attachment :store_image,
    :content_type => { content_type: %w(image/jpeg image/jpg image/png image/gif) }

  has_attached_file :content_image_1, 
	styles: { 
		thumbnail: '100x186',
		mobile:  '280x466',
		desktop: '400x666',
    product: '600x1000>'},
  	default_url: ""

  validates_attachment :content_image_1,
    :content_type => { content_type: %w(image/jpeg image/jpg image/png image/gif) }

  has_attached_file :content_image_2, 
	styles: { 
		thumbnail: '100x186',
		mobile:  '280x466',
		desktop: '400x666',
    product: '600x1000>'},
  	default_url: ""

  validates_attachment :content_image_2,
    :content_type => { content_type: %w(image/jpeg image/jpg image/png image/gif) }    

	has_many :events, dependent: :destroy
	has_many :group_codes, dependent: :destroy
	has_many :appointments, dependent: :destroy
	has_many :discounts, dependent: :destroy


  has_attached_file :content_image_3, 
	styles: { 
		thumbnail: '100x186',
		mobile:  '280x466',
		desktop: '400x666',
    product: '600x1000>'},
  	default_url: ""

  validates_attachment :content_image_3,
    :content_type => { content_type: %w(image/jpeg image/jpg image/png image/gif) }

  has_attached_file :manager_image, 
	styles: { 
		thumbnail: '100x186',
		mobile:  '280x466',
		desktop: '400x666',
    product: '600x1000>'},
  	default_url: "https://s3.amazonaws.com/alsformalwear-assets/images/manager-profile-image-default.png"

  validates_attachment :manager_image,
    :content_type => { content_type: %w(image/jpeg image/jpg image/png image/gif) }

	validates_presence_of :store_num, 
												:dist_manager, 
												:store_name, 
												:street_address, 
												:city, 
												:state, 
												:zip_code, 
												:phone_number, 
												:manager, 
												:latitude, 
												:longitude, 
												:mon_hours, 
												:tues_hours, 
												:wed_hours, 
												:thurs_hours, 
												:fri_hours, 
												:sat_hours, 
												:sun_hours, 
												:created_at, 
												:updated_at, 
												:google_url, 
												:shorthand, 
												:email, 
												# :district_manager_email, 
												# :manager_email, 
												:mon_open, 
												:mon_close, 
												:tues_open, 
												:tues_close, 
												:wed_open, 
												:wed_close, 
												:thurs_open, 
												:thurs_close, 
												:fri_open, 
												:fri_close, 
												:sat_open, 
												:sat_close, 
												:sun_open, 
												:sun_close, 
												:apple_url 

	reverse_geocoded_by :latitude, :longitude

	def format_for_select
		"#{self.state}: #{self.city} - #{store_name}"
	end

	def nightly_group_export
		events_to_be_exported = []
		events_to_be_exported << self.events.select { |event| event.created_at >= Time.zone.now.beginning_of_day - 1.days + 10.hours && event.is_group == true }
		events_to_be_exported << self.events.select { |event| event.updated_at >= Time.zone.now.beginning_of_day - 1.days + 10.hours && event.is_group == true && event.exported == false }
		events_to_be_exported.flatten!
		events_to_be_exported.compact!
		events_to_be_exported.uniq!
		sql = events_to_be_exported.map(&:convert_to_string_for_export).join
		sql
	end
	
	def self.update_location_hours
		csv_file_path = 'db/seeds/location-hours.csv'
		CSV.foreach(csv_file_path, :headers => true ).each_with_index do |row, i|
			current_location = self.find_by_store_num row["store_num"]
			row = row.to_hash.reject!{ |k| k == "store_num" }
			current_location.update_attributes(row)
		end
	end	

	def opened_hours(day)
		case day
		when "1"
			return self.mon_open
		when "2"
			return self.tues_open
		when "3"
			return self.wed_open
		when "4"
			return self.thurs_open
		when "5"
			return self.fri_open
		when "6"
			return self.sat_open
		when "0"
			return self.sun_open
		end
	end

	def closed_hours(day)
		case day
		when "1"
			return self.mon_close - 1
		when "2"
			return self.tues_close - 1
		when "3"
			return self.wed_close - 1
		when "4"
			return self.thurs_close - 1
		when "5"
			return self.fri_close - 1
		when "6"
			return self.sat_close - 1
		when "0"
			return self.sun_close - 1
		end
	end

	def self.prom_hours
		csv_file_path = 'db/seeds/locations-prom-update-hours.csv'
		CSV.foreach(csv_file_path, headers: true) do |row| 
			location = Location.find_by_store_num row["store_num"]
			if location.present?
				if location.update_attributes({
					mon_hours: row["mon_hours"],
					tues_hours: row["tues_hours"], 
					wed_hours: row["wed_hours"], 
					thurs_hours: row["thurs_hours"], 
					fri_hours: row["fri_hours"], 
					sat_hours: row["sat_hours"], 
					sun_hours: row["sun_hours"],

					mon_open: row["mon_open"],
					mon_close: row["mon_close"],
					tues_open: row["tues_open"],
					tues_close: row["tues_close"],
					wed_open: row["wed_open"],
					wed_close: row["wed_close"],
					thurs_open: row["thurs_open"],
					thurs_close: row["thurs_close"],
					fri_open: row["fri_open"],
					fri_close: row["fri_close"],
					sat_open: row["sat_open"],
					sat_close: row["sat_close"],
					sun_open: row["sun_open"],
					sun_close: row["sun_close"] 
				})
					puts "success"
				else
					puts location.errors.full_messages
				end
			end
		end
	end

	def self.update_apple_url
		csv_file_path = 'db/seeds/locations-update.csv'
		CSV.foreach(csv_file_path, :headers => true ) do |row|
			location = Location.find_by_shorthand row["shorthand"]
			location.update_attributes row.to_hash
		end
	end

	def remaining_group_codes
		self.group_codes.where(event_id: nil).count
	end

	def running_low_on_codes?
		if self.remaining_group_codes < 15
			return "Status => WARNING: Store number #{self.store_num} has only #{self.remaining_group_codes} unused group codes remaining. Time to add more."
		else
			return "Status => OK: Store number #{self.store_num} has #{self.remaining_group_codes} unused group codes remaining."
		end
	end
end


