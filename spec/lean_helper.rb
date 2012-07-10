require 'bundler/setup'
require 'rspec'
require 'active_support/core_ext'
require 'active_record'
require 'active_model'

module Rails
  mattr_accessor :root
  @@root = File.expand_path('../..',__FILE__)
  
  mattr_accessor :env
  @@env = 'test'
end

Dir[File.join(Rails.root, 'app/models/*.rb')].each do |file|
  filename = file.split('/').last.gsub('.rb', '').camelcase
  autoload filename, file
end

RSpec.configure do |config|
end



