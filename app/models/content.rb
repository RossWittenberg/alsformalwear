class Content < ActiveRecord::Base
	
	require 'csv'

	has_attached_file :image
  validates_attachment :image, 
  	styles: { thumbnail: '200x200'}, 
  	content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }

  validates_presence_of :page

  def self.seed_content
	  csv_file_path = 'db/seeds/cms_content.csv'
		CSV.foreach(csv_file_path, :headers => true ) do |row|
		  c = Content.create!(row.to_hash)
		end
	end

	def self.seed_group_offers
		group_offers_content_array = 
			[{ page:  "group_offers",
			description:  "school-offers-title-1",
			content_type:  "text",
			text: "WORK STUDY",
			html: true},

			{ page:  "group_offers",
			description:  "school-offers-title-2",
			content_type:  "text",
			text: "BECOME AL’S<br />PROM REP",
			html: true},

			{ page:  "group_offers",
			description:  "school-offers-title-3",
			content_type:  "text",
			text: "SCHOOL FUNDRAISING<br />CASH BACK PROGRAM",
			html: true},

			{ page:  "group_offers",
			description:  "school-offers-title-4",
			content_type:  "text",
			text: "SCHOOL<br />GROUP SALES",
			html: true},

			{ page:  "group_offers",
			description:  "other-offers-title-1",
			content_type:  "text",
			text: "CORPORATE<br />AFFINITY PROGRAM",
			html: true},

			{ page:  "group_offers",
			description:  "other-offers-title-2",
			content_type:  "text",
			text: "SOCIAL EVENT<br />FUND RAISING",
			html: true},

			{ page:  "group_offers",
			description:  "other-offers-title-3",
			content_type:  "text",
			text: "CUSTOM<br />WEDDING DISCOUNT",
			html: true},

			{ page:  "group_offers",
			description:  "school-offers-image-1",
			content_type:  "image"},

			{ page:  "group_offers",
			description:  "school-offers-image-2",
			content_type:  "image"},

			{ page:  "group_offers",
			description:  "school-offers-image-3",
			content_type:  "image"},

			{ page:  "group_offers",
			description:  "school-offers-image-4",
			content_type:  "image"},

			{ page:  "group_offers",
			description:  "other-offers-image-1",
			content_type:  "image"},

			{ page:  "group_offers",
			description:  "other-offers-image-2",
			content_type:  "image"},

			{ page:  "group_offers",
			description:  "other-offers-image-3",
			content_type:  "image"},

			{ page:  "group_offers",
			description:  "school-offers-link-1",
			content_type:  "link",
			text:  "/prom/#work-study"},

			{ page:  "group_offers",
			description:  "school-offers-link-2",
			content_type:  "link",
			text: "/prom/#rep-form"},

			{ page:  "group_offers",
			description:  "school-offers-link-3",
			content_type:  "link",
			text: "/prom/#school-fund" },

			{ page:  "group_offers",
			description:  "school-offers-link-4",
			content_type:  "link",
			text: "/prom/#school-group"},

			{ page:  "group_offers",
			description:  "other-offers-link-1",
			content_type:  "link",
			text: "/cap" },

			{ page:  "group_offers",
			description:  "other-offers-link-2",
			content_type:  "link",
			text: "/social-event/#social-fund"},

			{ page:  "group_offers",
			description:  "other-offers-link-3",
			content_type:  "link",
			text: "/wedding/#wedding-discount"} ]
			
			group_offers_content_array.each do |goc|
				c = Content.new(goc)
				c.save
			end
	end

	def self.seed_meta_data
		meta_data_content_array = 
		[ 
			# BYT
			{ page:  "other",
			description:  "byt-page-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Build Your Tuxedo",
			html: false},
			{ page:  "other",
			description:  "byt-page-description",
			content_type:  "meta-data",
			text: "Build your tuxedo for your next prom, wedding, quinceanera, or other special occasion.",
			html: false},
			{ page:  "other",
			description:  "byt-page-keywords",
			content_type:  "meta-data",
			text: "Build Your Tux, Al's Formal Wear BYT, Al's Formal Tuxedos",
			html: false},
			# About
			{ page:  "about",
			description:  "about-page-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - About Al's",
			html: false},
			{ page:  "about",
			description:  "about-page-description",
			content_type:  "meta-data",
			text: "Al's Formal Wear began in the Dallas area in 1952, and now has locations in Oklahoma, Louisiana, Colorado, and Texas.",
			html: false},
			{ page:  "about",
			description:  "about-page-keywords",
			content_type:  "meta-data",
			text: "About Al's Formal Wear, Tuxedo Texas, Houston Business, Al Sankary",
			html: false},
			# Group Offers
			{ page:  "group_offers",
			description:  "group-offers-page-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Group Offers for Tuxedo & Suit Rentals",
			html: false},
			{ page:  "group_offers",
			description:  "group-offers-page-description",
			content_type:  "meta-data",
			text: "Check out our various group offers to learn how you can save money on your next formal look.",
			html: false},
			{ page:  "group_offers",
			description:  "group-offers-page-keywords",
			content_type:  "meta-data",
			text: "Tuxedo Discount, Formal Wear Deals, Tuxedo Deals",
			html: false},
			# Locations
			{ page:  "other",
			description:  "locations-page-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Find Tuxedo & Suit Rental Locations",
			html: false},
			{ page:  "other",
			description:  "locations-page-description",
			content_type:  "meta-data",
			text: "Find the nearest Al's Formal Wear location and make an appointment today!",
			html: false},
			{ page:  "other",
			description:  "locations-page-keywords",
			content_type:  "meta-data",
			text: "al's formal wear locations, formal wear store, houston formal, texas formal wear store",
			html: false},
			# Contact/FAQ
			{ page:  "contact",
			description:  "contact-page-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Contact",
			html: false},
			{ page:  "contact",
			description:  "contact-page-description",
			content_type:  "meta-data",
			text: "Need to contact Al's Formal Wear? You can reach us by phone, email, or find your closest location",
			html: false},
			{ page:  "contact",
			description:  "contact-page-keywords",
			content_type:  "meta-data",
			text: "contact al's formal wear, als formal phone number, als formal customer service",
			html: false},
			# Terms/Privacy
			{ page:  "other",
			description:  "terms-page-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Terms and Privacy",
			html: false},
			{ page:  "other",
			description:  "terms-page-description",
			content_type:  "meta-data",
			text: "This Privacy Policy governs the manner in which Al's Formal Wear collects, uses, maintains and discloses information collected from users",
			html: false},
			{ page:  "other",
			description:  "terms-page-keywords",
			content_type:  "meta-data",
			text: "terms and privacy agreement, privacy terms als formal",
			html: false},
			# Account
			{ page:  "other",
			description:  "account-page-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Account",
			html: false},
			{ page:  "other",
			description:  "account-page-description",
			content_type:  "meta-data",
			text: "Create an Al's Formal Wear account and add your next special event and save your measurements for future use",
			html: false},
			{ page:  "other",
			description:  "account-page-keywords",
			content_type:  "meta-data",
			text: "als formal wear account",
			html: false},
			# Wedding
			{ page:  "wedding",
			description:  "wedding-page-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Wedding Tuxedo & Suit Rentals",
			html: false},
			{ page:  "wedding",
			description:  "wedding-page-description",
			content_type:  "meta-data",
			text: "Engaged? Check out how Al's Formal Wear can help you prepare for the big day.",
			html: false},
			{ page:  "wedding",
			description:  "wedding-page-keywords",
			content_type:  "meta-data",
			text: "wedding, als formal wear wedding, wedding tuxedo, destination wedding",
			html: false},
			# Prom
			{ page:  "prom",
			description:  "prom-page-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Prom Tuxedo & Suit Rentals",
			html: false},
			{ page:  "prom",
			description:  "prom-page-description",
			content_type:  "meta-data",
			text: "Al's Formal Wear has everything you need for you to look and feel your best at Prom.",
			html: false},
			{ page:  "prom",
			description:  "prom-page-keywords",
			content_type:  "meta-data",
			text: "prom tux, junior prom, senior prom, formal prom tuxedo",
			html: false},
			# Social Event
			{ page:  "social-event",
			description:  "social-event-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Social Event Tuxedo & Suit Rentals",
			html: false},
			{ page:  "social-event",
			description:  "social-event-description",
			content_type:  "meta-data",
			text: "Al's Formal Wear can outfit your next special event.",
			html: false},
			{ page:  "social-event",
			description:  "social-event-keywords",
			content_type:  "meta-data",
			text: "what to wear to a wedding, formal suit",
			html: false},
			# Quinceanera
			{ page:  "quinceanera",
			description:  "quinceanera-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Quinceanera Tuxedo & Suit Rentals",
			html: false},
			{ page:  "quinceanera",
			description:  "quinceanera-description",
			content_type:  "meta-data",
			text: "Al's Formal Wear has everything you need for you to look and feel your best at your next Quinceanera.",
			html: false},
			{ page:  "quinceanera",
			description:  "quinceanera-keywords",
			content_type:  "meta-data",
			text: "quince tux, quinceanera tuxedo houston",
			html: false},
			# Measurements
			{ page:  "other",
			description:  "measurements-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear - Measurements for Tuxedo & Suit Rentals",
			html: false},
			{ page:  "other",
			description:  "measurements-description",
			content_type:  "meta-data",
			text: "Use our website to record your measurements for future formal occasions.",
			html: false},
			{ page:  "other",
			description:  "measurements-keywords",
			content_type:  "meta-data",
			text: "save your tux measurements, how to measure yourself for a tux",
			html: false},
			# Home
			{ page:  "home",
			description:  "home-title",
			content_type:  "meta-data",
			text: "Al's Formal Wear",
			html: false},
			{ page:  "home",
			description:  "home-description",
			content_type:  "meta-data",
			text: "Look Great. Look Great. Wonderful Memories.",
			html: false},
			{ page:  "home",
			description:  "home-keywords",
			content_type:  "meta-data",
			text: "tuxedos formalwear",
			html: false}
 		]
			
			meta_data_content_array.each do |mdoc|
				c = Content.new(mdoc)
				c.save
			end
	end
end


