require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TwitterLike
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.web_console.development_only = false
    config.generators.test_framework = :rspec
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      "<div class=\"field_with_errors control-group error\">#{html_tag}</div>".html_safe
    }

    # https://stackoverflow.com/questions/29417328/how-to-disable-cannot-render-console-from-on-rails
    config.web_console.permissions = '95.55.24.61'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
