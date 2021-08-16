Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], size: 4, network_timeout: 5 }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], size: 4, network_timeout: 5 }
end
