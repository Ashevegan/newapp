#require_relative 'boot'

require 'rails/all'
# Pick the frameworks you want:





# require "rails/test_unit/railtie"



# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module Nameofapp
  class Application < Rails::Application
    # Settin
    #
    # gs in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache'
    config.assets.initialize_on_precompile = false
  end
end
