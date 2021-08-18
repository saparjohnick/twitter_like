require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../sidekiq_scheduler.yml', __FILE__))
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], size: 4, network_timeout: 5 }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], size: 4, network_timeout: 5 }
end
