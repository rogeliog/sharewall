# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:all) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] =  OmniAuth::AuthHash.new({
      'provider'=>'github',
      'uid'=>'123456',
      'info'=>{'nickname'=>'rogeliog', 'email' => 'rogelio@innku.com'},
      'extra' => {'raw_info' => {'avatar_url' => 'https://github.com/ohyeah.jpg'}}
    })
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    OmniAuth.config.test_mode = false
  end
end
