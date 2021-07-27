CarrierWave.configure do |config|
  # config.fog_credentials = {

  # }
  config.storage = Fog::Storage.new(
    provider: 'AWS',
    aws_access_key_id: ENV['S3_ACCESS_KEY'],
    aws_secret_access_key: ENV['S3_SECRET_KEY'],
    region: 'eu-west-1'
  )
  config.fog_directory = ENV['S3_BUCKET']
  config.fog_public = false
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'carrier_wave'

  CarrierWave::SanitizedFile.sanitize_regexp = /[^a-zA-Z0-9.\-_]/
end
