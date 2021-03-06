CarrierWave.configure do |config|
  config.fog_credentials = { 
    :provider              => 'AWS',
    :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET_KEY'],
    :host                  => "s3.us-east-1.amazonaws.com",
    :region                => 'us-east-1'
  }
  config.storage = :fog
  # config.fog_use_ssl_for_aws = false
  config.fog_directory     =  ENV['S3_BUCKET']

  config.root = Rails.root.join('tmp')
  config.cache_dir      = 'carrier_wave'
  config.fog_public     = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}

  CarrierWave::SanitizedFile.sanitize_regexp = /[^a-zA-Z0-9\.\-_]/
end
