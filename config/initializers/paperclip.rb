S3_CONFIG = YAML.load_file("#{Rails.root}/config/s3.yml")[Rails.env]
Paperclip::Attachment.default_options.merge!(
  :storage => :fog,
  :fog_credentials => {
    :provider => 'AWS',
    :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
  	:region => 'us-east-1'

  },
  :fog_directory => ENV['S3_BUCKET_NAME'], 
  :bucket => ENV['S3_BUCKET_NAME'],
)