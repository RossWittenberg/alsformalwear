Spree::User.class_eval do
	
  has_many :favorites
  has_many :variants, through: :favorites

  has_many :looks, dependent: :destroy
	has_many :events, dependent: :destroy
	has_many :identities,
							dependent:  :destroy,
							inverse_of: :user
	has_one :measurement, dependent: :destroy

  validates :password, confirmation: false
  validates :password, length: { in: 6..128 }, on: :update, allow_blank: true
  validates :password, presence: true, length: { in: 6..128 }, on: :create
  # pw complexity validation:
  validate :password_complexity

  validates :phone_number, format: { with: /\A([01][- .()])?(\(\d{3}\)|\d{3})[- .]*?\d{3}[- .]*\d{4}\Z/, message: "Must be a valid 10-digit phone number." }, if: Proc.new { |u| u.phone_number.present? }

  validates_format_of :first_name, :with => /([^\d\W]|[-])*/, :message => "Must begin with a letter", allow_blank: true
  validates_format_of :last_name, :with => /([^\d\W]|[-])*/, :message => "Must begin with a letter", allow_blank: true

  validates :email, presence: true
  validates :email, uniqueness: true, unless: Proc.new { |user| user.deleted_at? }

  # validates_email_format_of :email, message: "Not a vaid email address"

  before_save :formatPhoneNumberForDB, if: Proc.new { |u| u.phone_number.present? }

  devise :database_authenticatable, :registerable,
       	 :recoverable, :rememberable, :trackable

	devise :omniauthable, :omniauth_providers => [:facebook, :gplus, :twitter]


  def district_manager?
    district_manager_role = Spree::Role.find_by_name "district manager"
    self.spree_roles.include? district_manager_role
  end

  def self.to_users_csv
    attributes = %w{email first_name last_name phone_number, created_at}
    CSV.generate( { headers: true } ) do |csv|
      csv << attributes
      self.all.each do |user|
        csv << [ user.email, user.first_name, user.last_name, user.phone_number, (user.created_at.in_time_zone("Central Time (US & Canada)")).strftime("%m/%d/%Y") ]
      end 
    end

  end

	def name
		"#{self.first_name} #{self.last_name}"
	end

  def formatPhoneNumberForDB
    onlyNums = [];
    self.phone_number.gsub(/[0-9]/) { |match| onlyNums.push(match) }
    self.phone_number = onlyNums.join("").insert(3, "-").insert(7, "-")
  end

  private

  def password_complexity
    complexity = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./
    if password.present? and not complexity.match(password)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
  end

  public

  def pending?
    !self.confirmed?
  end


end
