require_relative "spec_helper_unit"

ENV["RAILS_ENV"] ||= "test"

# ActiveRecord
require "yaml"
require "active_record"
require 'vcr'

require File.join(RAILS_ROOT, "lib", "email_format_validator")

ActiveRecord::Base.include_root_in_json = false
ActiveRecord::Base.establish_connection(
  YAML.load(File.read(RAILS_ROOT + "config/database.yml"))["test"]
)

$: << File.join(RAILS_ROOT, 'spec')

# DatabaseCleaner
require "database_cleaner"
require 'support/helpers'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# Enter database configurations into ActiveRecord
ActiveRecord::Base.send(:configurations=, YAML::load(ERB.new(IO.read(RAILS_ROOT + "config/database.yml")).result))
