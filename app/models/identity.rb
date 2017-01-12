class Identity < ActiveRecord::Base
  belongs_to :user,
                class_name: Spree::User,
                inverse_of: :identities

  validates :provider, inclusion: { in: %w(twitter facebook gplus) }
end
