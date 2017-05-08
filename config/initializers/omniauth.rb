Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "560031255920-vn83thr5bi901bt8agehbngtemhtd3c8.apps.googleusercontent.com", "AE9N4mcs-8GonDYXa5vsLYdq", {
    provider_ignores_state: true,
    scope: ["plus.login", "plus.me", "userinfo.email", "userinfo.profile"],
    access_type: 'offline'
  }
end
