require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load dotenv only in development or test environment
if %w[development test].include? ENV["RAILS_ENV"]
  Dotenv::Railtie.load
end

module SaltedgeTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.salt_edge_app_id = ENV.fetch("SALT_EDGE_APP_ID")
    config.salt_edge_secret = ENV.fetch("SALT_EDGE_SECRET")
    config.callback_user_name = ENV.fetch("CALLBACK_USER_NAME")
    config.callback_user_password = ENV.fetch("CALLBACK_USER_PASSWORD")
  end
end
