# Configure Solidus Preferences
# See http://docs.solidus.io/Spree/AppConfiguration.html for details

require "#{Rails.root}/lib/spree/product_filters"
require "#{Rails.root}/lib/spree/custom_search"
require "#{Rails.root}/lib/spree/search/base_override"

Devise.setup do |config|
  config.allow_unconfirmed_access_for = 3.days
  config.router_name = :spree
end

Spree::Config.searcher_class = Spree::CustomSearch

Spree::Auth::Config[:confirmable] = true

Spree.config do |config|



 # Without this preferences are loaded and persisted to the database. This
  # changes them to be stored in memory.
  # This will be the default in a future version.
  config.use_static_preferences!

  # Core:

  # Default currency for new sites
  config.currency = "USD"

  # from address for transactional emails
  config.mails_from = "ross@verbalplusvisual.com"

  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false

  # When set, product caches are only invalidated when they fall below or rise
  # above the inventory_cache_threshold that is set. Default is to invalidate cache on
  # any inventory changes.
  # config.inventory_cache_threshold = 3



  # Frontend:

  # Custom logo for the frontend
  config.logo = "spree/frontend/stack-color.png"

  # Template to use when rendering layout
  # config.layout = "spree/layouts/spree_application"


  # Admin:

  # Custom logo for the admin
  config.admin_interface_logo = "spree/frontend/stack-color.png"

  # Gateway credentials can be configured statically here and referenced from
  # the admin. They can also be fully configured from the admin.
  #
  # config.static_model_preferences.add(
  #   Spree::Gateway::StripeGateway,
  #   'stripe_env_credentials',
  #   secret_key: ENV['STRIPE_SECRET_KEY'],
  #   publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  #   server: Rails.env.production? ? 'production' : 'test',
  #   test: !Rails.env.production?
  # )

  # Example:
  # Uncomment to override the default site name.


  Paperclip::Attachment.default_options[:s3_protocol] = "https"
  Spree::Image.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode('{"mini":"100x100\u003E","small":"150x150\u003E","medium":"300x300\u003E","product":"460x460\u003E","large":"1200x1200\u003E"}').symbolize_keys!
  Spree::Image.attachment_definitions[:attachment][:path] = "products/:id/:style/:basename.:extension"
  Spree::Image.attachment_definitions[:attachment][:url] = ':path'
  Spree::Image.attachment_definitions[:attachment][:default_url] = ''
  Spree::Image.attachment_definitions[:attachment][:default_style] = 'product'


end

Spree.user_class = "Spree::LegacyUser"

