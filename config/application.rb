require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups + [:phrasebook])

module Phrasebook
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Make browserify-rails work with CoffeeScript.
    # config.browserify_rails.commandline_options = "-t coffeeify --extension=\".js.coffee\""

    # The sources contain default strings in English, so it is hard-coded here
    config.i18n.available_locales = Dir["#{Rails.root}/config/locales/??.yml"].map {|d| d.split('/').last.split('.').first} + [:en]
    config.i18n.default_locale = :de
  end
end
