require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module BlogTask
  class Application < Rails::Application
    config.eager_load_paths << Rails.root.join("lib")
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))

    config.api_only = true

    # Include Action View Railtie to enable serving static assets for Sidekiq Web UI
    require "action_view/railtie"

    # Middleware to serve static files (needed for Sidekiq Web UI)
    config.public_file_server.enabled = true

    # Enable sessions, required for Sidekiq Web UI
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: "_namespace_key"
  end
end
