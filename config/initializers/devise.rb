Devise.secret_key = "fc68967f410d66ae8854f30faea50870211d258786d1538aa0e79b075f592f0914bbc6125b3e1c1b047d50313280fdc88d31"

Devise.setup do |config|

  config.allow_unconfirmed_access_for = 3.days

  config.mailer = 'DeviseMailer'
  config.mailer_sender = "ross@verbalplusvisual.com"

  config.router_name = :spree

  config.reconfirmable = false

  config.omniauth :gplus   , ENV['GOOGLE_CLIENT_ID']    , ENV['GOOGLE_CLIENT_SECRET']
  config.omniauth :facebook, ENV['FACEBOOK_APP_ID']     , ENV['FACEBOOK_APP_SECRET'],
                    scope:       'email',
                    info_fields: 'email,first_name,last_name'
  config.omniauth :twitter , ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
end
