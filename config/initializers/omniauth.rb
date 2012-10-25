OmniAuth.config.logger = Rails.logger
#puts  "CHIno #{APP_CONFIG['GITHUB_SECRET']}"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, APP_CONFIG[:github_token], APP_CONFIG[:github_secret]
end
