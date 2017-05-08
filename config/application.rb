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
  end
end
