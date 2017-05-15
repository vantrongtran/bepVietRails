require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BepVietRails
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/lib/**)
    config.eager_load_paths += %W(#{config.root}/lib)
    config.eager_load_paths += %W(#{config.root}/lib/**)

    config.i18n.default_locale = :en
    config.active_job.queue_adapter = :sidekiq
    Rails.application.routes.default_url_options[:host] = "localhost:3000"
  end
end
